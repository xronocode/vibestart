#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/test_helpers.sh"
source "$REPO_ROOT/lib/json.sh"

tmpdir="$(make_temp_dir)"
trap 'rm -rf "$tmpdir"' EXIT

json_file="$tmpdir/mcp.json"
printf '%s\n' '{"mcpServers":{}}' > "$json_file"

json_set "$json_file" ".mcpServers.conport" '{
  "command": "uvx",
  "args": ["context-portal-mcp"]
}'

assert_json_expr "$json_file" '.mcpServers.conport.command == "uvx"'
assert_json_expr "$json_file" '.mcpServers.conport.args == ["context-portal-mcp"]'
assert_json_expr "$json_file" 'has("conport") | not'

left_file="$tmpdir/left.json"
right_file="$tmpdir/right.json"
merged_file="$tmpdir/merged.json"
printf '%s\n' '{"mcpServers":{"conport":{"command":"uvx"}}}' > "$left_file"
printf '%s\n' '{"mcpServers":{"entire":{"command":"entire-mcp"}}}' > "$right_file"

json_merge "$left_file" "$right_file" "$merged_file"

assert_json_expr "$merged_file" '.mcpServers.conport.command == "uvx"'
assert_json_expr "$merged_file" '.mcpServers.entire.command == "entire-mcp"'

echo "PASS: test_json"
