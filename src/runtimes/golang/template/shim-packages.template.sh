#!/usr/bin/env bash

export GOBIN="__GOBIN_PATH__"

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    printf "\033[91mError: file %s not found.\033[0m\n" "__NAME__"
    exit 1
fi

exec "${BIN_PATH}" "$@"