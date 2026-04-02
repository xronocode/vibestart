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

TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for test_script in "$TEST_DIR"/test_*.sh; do
    "$test_script"
done

echo "PASS: all tests"
