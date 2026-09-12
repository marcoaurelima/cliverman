#!/usr/bin/env bash

export npm_config_prefix="__NPM_PREFIX__/.yarn"
export YARN_GLOBAL_FOLDER="__NPM_PREFIX__/.yarn"

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    printf "\033[91mError: nodejs %s is not installed or the installation may be corrupted.\033[0m" "__VERSION__"
    printf "  Use \`cliverman install nodejs:%s\` to reinstall.\n" "__VERSION__"
    exit 1
fi

exec "${BIN_PATH}" "$@"