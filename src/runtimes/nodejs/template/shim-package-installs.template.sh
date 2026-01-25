#!/usr/bin/env bash
set -e

NODEJS_BIN="__INSTALLS_PATH__/nodejs/__VERSION__/bin/__NAME__"

if [[ ! -x "$NODEJS_BIN" ]]; then
    echo -e "\033[91m Erro: arquivo __NAME__ não encontrado.\033[0m"
    exit 1
fi

exec "$NODEJS_BIN" "$@"