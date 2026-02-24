#!/usr/bin/env bash

export npm_config_prefix="__NPM_PREFIX__/.yarn"
export YARN_GLOBAL_FOLDER="__NPM_PREFIX__/.yarn"

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    echo -e "\033[91m Error: nodejs __VERSION__ is not installed or the installation may be corrupted.\033[0m"
    echo -e "  Use \`cliverman install nodejs:__VERSION__\` to reinstall."
    exit 1
fi

exec "${BIN_PATH}" "$@"