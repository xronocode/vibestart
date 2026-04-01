#!/usr/bin/env bash

set -euo pipefail

if [[ "${BASH_VERSINFO[0]:-0}" -lt 4 ]]; then
    if [[ -x "/opt/homebrew/bin/bash" ]]; then
        exec /opt/homebrew/bin/bash "$0" "$@"
    fi

    if [[ -x "/usr/local/bin/bash" ]]; then
        exec /usr/local/bin/bash "$0" "$@"
    fi

    echo "tests require Bash 4.0+" >&2
    exit 1
fi

TEST_HELPERS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$TEST_HELPERS_DIR/../.." && pwd)"

fail() {
    local message="$1"
    echo "FAIL: $message" >&2
    exit 1
}

assert_file_exists() {
    local path="$1"
    [[ -f "$path" ]] || fail "expected file to exist: $path"
}

assert_contains() {
    local haystack="$1"
    local needle="$2"
    [[ "$haystack" == *"$needle"* ]] || fail "expected output to contain: $needle"
}

assert_json_expr() {
    local file="$1"
    local expr="$2"

    command -v jq >/dev/null 2>&1 || fail "jq is required for test assertions"
    jq -e "$expr" "$file" >/dev/null || fail "expected jq expression to pass for $file: $expr"
}

make_temp_dir() {
    mktemp -d
}
