#!/bin/bash
# lib/json.sh — JSON Utilities with jq Fallback
# MODULE_ID: M-JSON
# CONTRACT:
#   PURPOSE: JSON manipulation with fallback for systems without jq
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
    local key="$2"
    local value="$3"
    
    if [[ ! -f "$file" ]]; then
        echo "[JSON] Error: File not found: $file" >&2
        return 1
    fi
    
    if json_has_jq; then
        local tmp
        tmp=$(mktemp)
        
        if jq --arg k "$key" --arg v "$value" '.[$k] = $v' "$file" > "$tmp" 2>/dev/null; then
            mv "$tmp" "$file"
            return 0
        else
            rm -f "$tmp"
            return 1
        fi
    else
        # Fallback: simple string replacement (limited)
        # Only works for simple string values at top level
        local tmp
        tmp=$(mktemp)
        
        if sed 's/"'"$key"'"[[:space:]]*:[[:space:]]*"[^"]*"/"'"$key"'": "'"$value"'"/' "$file" > "$tmp" 2>/dev/null; then
            mv "$tmp" "$file"
            return 0
        else
            rm -f "$tmp"
            return 1
        fi
    fi
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

declare -f json_has_jq json_get json_set json_merge json_create json_validate json_add_to_array json_delete_key &>/dev/null || {
    echo "[JSON] Error: Export validation failed" >&2
    exit 1
}
