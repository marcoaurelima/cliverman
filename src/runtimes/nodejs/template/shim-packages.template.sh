#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

BIN_PATH="__BIN_PATH__"

if [[ ! -x "${BIN_PATH}" ]]; then
    echo -e "\033[91m Erro: arquivo __NAME__ não encontrado.\033[0m"
    exit 1
fi

exec "${BIN_PATH}" "$@"