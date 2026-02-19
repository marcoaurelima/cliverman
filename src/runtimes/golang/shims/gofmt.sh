#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

GOFMT_BIN="__INSTALLS_PATH__/golang/__VERSION__/go/bin/gofmt"

 # Check if the Go binary exists
if [[ ! -x "$GOFMT_BIN" ]]; then
    echo -e "\033[91m Error: gofmt is not installed at $GOFMT_BIN\033[0m" >&2
    echo -e "  Use \`cliverman install golang:__VERSION__\` to install."
    exit 1
fi

exec "$GOFMT_BIN" "$@"