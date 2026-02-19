#!/usr/bin/env bash

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    echo -e "\033[91m Error: nodejs __VERSION__ is not installed or the installation may be corrupted.\033[0m"
    echo -e "  Use \`cliverman install nodejs:__VERSION__\` to reinstall."
    exit 1
fi

exec "${BIN_PATH}" "$@"