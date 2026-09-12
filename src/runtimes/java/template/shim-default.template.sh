#!/usr/bin/env bash

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    printf "\033[91mError: java %s is not installed or the installation may be corrupted.\033[0m\n" "__VERSION__"
    printf "  Use \`cliverman install java:%s\` to reinstall.\n" "__VERSION__"
    exit 1
fi

exec "${BIN_PATH}" "$@"