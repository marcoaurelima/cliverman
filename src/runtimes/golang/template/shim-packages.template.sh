#!/usr/bin/env bash

export GOBIN="__GOBIN_PATH__"

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    echo -e "\033[91m Error: file __NAME__ not found.\033[0m"
    exit 1
fi

exec "${BIN_PATH}" "$@"