#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/test_helpers.sh"

run_generator_test() {
    local env_name="$1"
    local script_path="$2"
    local generator_fn="$3"
    local output_path="$4"

    local tmpdir
    tmpdir="$(make_temp_dir)"

    (
        cd "$tmpdir"
        source "$REPO_ROOT/lib/ui.sh"
        source "$script_path"
        "$generator_fn" full enabled

        assert_file_exists "$output_path"
        assert_json_expr "$output_path" '.mcpServers.conport.command == "uvx"'
        assert_json_expr "$output_path" '.mcpServers.conport.args == ["context-portal-mcp"]'
        assert_json_expr "$output_path" '.mcpServers.entire.command == "entire-mcp"'
    )

    rm -rf "$tmpdir"
    echo "PASS: generator_$env_name"
}

run_qwen_generator_test() {
    local tmpdir
    tmpdir="$(make_temp_dir)"

    (
        cd "$tmpdir"
        source "$REPO_ROOT/lib/ui.sh"
        source "$REPO_ROOT/lib/config/qwen.sh"
        generate_qwen_mcp full enabled

        assert_file_exists ".qwen/mcp-servers.json"
        assert_json_expr ".qwen/mcp-servers.json" '.mcpServers.conport.command == "uvx"'
        assert_json_expr ".qwen/mcp-servers.json" '.mcpServers.conport.args == ["context-portal-mcp"]'
        assert_json_expr ".qwen/mcp-servers.json" '.mcpServers.entire == null'
    )

    rm -rf "$tmpdir"
    echo "PASS: generator_qwen"
}

run_generator_test "kilo" "$REPO_ROOT/lib/config/kilo.sh" "generate_kilo_mcp" ".kilo/mcp_settings.json"
run_generator_test "claude" "$REPO_ROOT/lib/config/claude.sh" "generate_claude_mcp" ".claude/mcp-servers.json"
run_qwen_generator_test
