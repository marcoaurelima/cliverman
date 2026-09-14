#!/usr/bin/env bash

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    printf "\033[91mError: flutter %s is not installed or the installation may be corrupted.\033[0m\n" "__VERSION__"
    printf "  Use \`cliverman install flutter:%s\` to reinstall.\n" "__VERSION__"
    exit 1
fi

# Export bin directory to PATH before exec, so that flutter can find its dependencies and 
# supress warnings about missing dependencies.
BIN_DIR="$(dirname "${BIN_PATH}")"
export PATH="${BIN_DIR}:${PATH}"

exec "${BIN_PATH}" "$@"