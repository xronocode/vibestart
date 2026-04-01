#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/test_helpers.sh"

output="$(
    cd "$REPO_ROOT"
    env \
        PATH="$PATH" \
        HOME="$HOME" \
        TERM="${TERM:-xterm-256color}" \
        CODEX_CI=1 \
        CODEX_THREAD_ID=test-thread \
        CODEX_INTERNAL_ORIGINATOR_OVERRIDE=codex_vscode \
        "$REPO_ROOT/vs-init" --auto --dry-run
)"

assert_contains "$output" "Environment:  codex"
assert_contains "$output" "AGENTS.md (context file)"
assert_contains "$output" ".codex/config.toml (MCP config)"

echo "PASS: test_vs_init_dry_run"
