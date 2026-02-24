#!/usr/bin/env bash

export npm_config_prefix="__NPM_PREFIX__/.yarn"
export YARN_GLOBAL_FOLDER="__NPM_PREFIX__/.yarn"

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    echo -e "\033[91m Error: file __NAME__ not found.\033[0m"
    exit 1
fi

exec "${BIN_PATH}" "$@"