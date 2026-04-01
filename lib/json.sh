#!/bin/bash
# lib/json.sh — JSON Utilities with jq/Python Fallback
# MODULE_ID: M-JSON
# CONTRACT:
#   PURPOSE: JSON manipulation with jq/Python fallback
#   SCOPE: JSON parsing, merging, setting values
#   DEPENDS: —
#   EXPORTS:
#     json_get()      — get value from JSON file
#     json_set()      — set value in JSON file
#     json_merge()    — merge two JSON files
#     json_create()   — create empty JSON object
#     json_validate() — validate JSON syntax

set -e

# ═══════════════════════════════════════════════════════════════════════════
# Check jq Availability
# ═══════════════════════════════════════════════════════════════════════════

# json_has_jq: Check if jq is available
# USAGE: if json_has_jq; then ...
# RETURNS: 0 = available, 1 = not available
json_has_jq() {
    command -v jq &>/dev/null
}

# json_has_python: Check if python3 is available
# USAGE: if json_has_python; then ...
# RETURNS: 0 = available, 1 = not available
json_has_python() {
    command -v python3 &>/dev/null
}

# json_normalize_path: Normalize a dotted path for helper functions
# USAGE: path=$(json_normalize_path ".parent.child")
# RETURNS: Dotted path without leading dots
json_normalize_path() {
    local path="${1#.}"
    echo "$path"
}

# ═══════════════════════════════════════════════════════════════════════════
# JSON Operations
# ═══════════════════════════════════════════════════════════════════════════

# json_get: Get value from JSON file
# USAGE: value=$(json_get "file.json" ".key")
# RETURNS: Value or empty string on error
json_get() {
    local file="$1"
    local key="$2"
    
    if [[ ! -f "$file" ]]; then
        echo ""
        return 1
    fi
    
    if json_has_jq; then
        jq -r "$key" "$file" 2>/dev/null || echo ""
    elif json_has_python; then
        python3 - "$file" "$key" << 'PY' 2>/dev/null || echo ""
import json
import sys

file_path, key = sys.argv[1:3]
with open(file_path, "r", encoding="utf-8") as handle:
    data = json.load(handle)

parts = [part for part in key.lstrip(".").split(".") if part]
value = data
for part in parts:
    if isinstance(value, dict):
        value = value.get(part, "")
    else:
        value = ""
        break

if isinstance(value, (dict, list)):
    print(json.dumps(value))
else:
    print("" if value is None else value)
PY
    else
        # Fallback: grep and sed (limited support for simple keys)
        local key_name
        key_name=$(echo "$key" | sed 's/\.//g' | sed 's/\[.*//')
        
        grep "\"$key_name\"" "$file" 2>/dev/null | head -1 | \
            sed -n 's/.*"'"$key_name"'"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'
    fi
}

# json_set: Set value in JSON file
# USAGE: json_set "file.json" "key" "value"
# RETURNS: 0 = success, 1 = failure
json_set() {
    local file="$1"
    local key
    key=$(json_normalize_path "$2")
    local value="$3"
    local value_file
    value_file=$(mktemp)
    printf '%s' "$value" > "$value_file"
    
    if [[ ! -f "$file" ]]; then
        echo "[JSON] Error: File not found: $file" >&2
        rm -f "$value_file"
        return 1
    fi
    
    if json_has_jq; then
        local tmp
        local path_json
        tmp=$(mktemp)
        path_json=$(jq -cn --arg key "$key" '$key | split(".")')

        if jq -e . "$value_file" >/dev/null 2>&1; then
            if jq --argjson path "$path_json" --slurpfile value "$value_file" 'setpath($path; $value[0])' "$file" > "$tmp" 2>/dev/null; then
                mv "$tmp" "$file"
                rm -f "$value_file"
                return 0
            fi
        elif jq --argjson path "$path_json" --rawfile value "$value_file" 'setpath($path; $value)' "$file" > "$tmp" 2>/dev/null; then
            mv "$tmp" "$file"
            rm -f "$value_file"
            return 0
        fi

        rm -f "$tmp" "$value_file"
        return 1
    elif json_has_python; then
        local tmp
        tmp=$(mktemp)

        if python3 - "$file" "$key" "$value_file" > "$tmp" << 'PY' 2>/dev/null
import json
import sys

file_path, key, value_path = sys.argv[1:4]

with open(file_path, "r", encoding="utf-8") as handle:
    data = json.load(handle)

with open(value_path, "r", encoding="utf-8") as handle:
    raw_value = handle.read()

try:
    value = json.loads(raw_value)
except json.JSONDecodeError:
    value = raw_value

parts = [part for part in key.split(".") if part]
if not parts:
    raise SystemExit(1)

current = data
for part in parts[:-1]:
    existing = current.get(part)
    if not isinstance(existing, dict):
        existing = {}
        current[part] = existing
    current = existing

current[parts[-1]] = value

json.dump(data, sys.stdout, indent=2)
sys.stdout.write("\n")
PY
        then
            mv "$tmp" "$file"
            rm -f "$value_file"
            return 0
        fi

        rm -f "$tmp" "$value_file"
        return 1
    fi

    echo "[JSON] Error: json_set requires jq or python3 for safe updates" >&2
    rm -f "$value_file"
    return 1
}

# json_merge: Merge two JSON objects
# USAGE: json_merge "file1.json" "file2.json" "output.json"
# RETURNS: 0 = success, 1 = failure
json_merge() {
    local file1="$1"
    local file2="$2"
    local output="$3"
    
    if [[ ! -f "$file1" ]] || [[ ! -f "$file2" ]]; then
        echo "[JSON] Error: Input files not found" >&2
        return 1
    fi
    
    if json_has_jq; then
        jq -s '.[0] * .[1]' "$file1" "$file2" > "$output" 2>/dev/null
        return $?
    elif json_has_python; then
        python3 - "$file1" "$file2" "$output" << 'PY' 2>/dev/null
import json
import sys

file1, file2, output = sys.argv[1:4]

def merge(base, override):
    if isinstance(base, dict) and isinstance(override, dict):
        result = dict(base)
        for key, value in override.items():
            if key in result:
                result[key] = merge(result[key], value)
            else:
                result[key] = value
        return result
    return override

with open(file1, "r", encoding="utf-8") as handle:
    left = json.load(handle)
with open(file2, "r", encoding="utf-8") as handle:
    right = json.load(handle)

merged = merge(left, right)
with open(output, "w", encoding="utf-8") as handle:
    json.dump(merged, handle, indent=2)
    handle.write("\n")
PY
        return $?
    else
        # Fallback: not a true merge, just use first file
        # This is a significant limitation
        echo "[JSON] Warning: json_merge requires jq for proper operation" >&2
        cp "$file1" "$output"
        return 1
    fi
}

# json_create: Create empty JSON object
# USAGE: json_create "file.json"
# RETURNS: 0 = success
json_create() {
    local file="$1"
    
    echo '{}' > "$file"
    return 0
}

# json_validate: Validate JSON syntax
# USAGE: json_validate "file.json"
# RETURNS: 0 = valid, 1 = invalid
json_validate() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        return 1
    fi
    
    if json_has_jq; then
        jq '.' "$file" >/dev/null 2>&1
        return $?
    elif json_has_python; then
        python3 -m json.tool "$file" >/dev/null 2>&1
        return $?
    else
        # Basic validation: check for balanced braces
        local opens closes
        opens=$(grep -o '{' "$file" | wc -l | tr -d ' ')
        closes=$(grep -o '}' "$file" | wc -l | tr -d ' ')
        
        if [[ "$opens" -eq "$closes" ]]; then
            # Also check brackets
            local bracket_opens bracket_closes
            bracket_opens=$(grep -o '\[' "$file" | wc -l | tr -d ' ')
            bracket_closes=$(grep -o '\]' "$file" | wc -l | tr -d ' ')
            
            if [[ "$bracket_opens" -eq "$bracket_closes" ]]; then
                return 0
            fi
        fi
        return 1
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Advanced Operations (jq required)
# ═══════════════════════════════════════════════════════════════════════════

# json_add_to_array: Add value to JSON array
# USAGE: json_add_to_array "file.json" ".array" "value"
# RETURNS: 0 = success, 1 = failure
json_add_to_array() {
    local file="$1"
    local key="$2"
    local value="$3"
    
    if ! json_has_jq; then
        echo "[JSON] Error: json_add_to_array requires jq" >&2
        return 1
    fi
    
    if [[ ! -f "$file" ]]; then
        return 1
    fi
    
    local tmp
    tmp=$(mktemp)
    
    if jq --arg v "$value" "$key += [\$v]" "$file" > "$tmp" 2>/dev/null; then
        mv "$tmp" "$file"
        return 0
    else
        rm -f "$tmp"
        return 1
    fi
}

# json_delete_key: Delete key from JSON
# USAGE: json_delete_key "file.json" ".key"
# RETURNS: 0 = success, 1 = failure
json_delete_key() {
    local file="$1"
    local key="$2"
    
    if ! json_has_jq; then
        echo "[JSON] Error: json_delete_key requires jq" >&2
        return 1
    fi
    
    if [[ ! -f "$file" ]]; then
        return 1
    fi
    
    local tmp
    tmp=$(mktemp)
    
    if jq "del($key)" "$file" > "$tmp" 2>/dev/null; then
        mv "$tmp" "$file"
        return 0
    else
        rm -f "$tmp"
        return 1
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Export Validation
# ═══════════════════════════════════════════════════════════════════════════

declare -f json_has_jq json_has_python json_normalize_path json_get json_set json_merge json_create json_validate json_add_to_array json_delete_key &>/dev/null || {
    echo "[JSON] Error: Export validation failed" >&2
    exit 1
}
