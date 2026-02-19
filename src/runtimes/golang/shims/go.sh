#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

GO_BIN="__INSTALLS_PATH__/golang/__VERSION__/go/bin/go"

 # Check if the Go binary exists
if [[ ! -x "$GO_BIN" ]]; then
    echo -e "\033[91m Error: go __VERSION__ is not installed at $GO_BIN\033[0m" >&2
    echo -e "  Use \`cliverman install golang:__VERSION__\` to install."
    exit 1
fi

exec "$GO_BIN" "$@"