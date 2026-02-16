#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

GOFMT_BIN="__INSTALLS_PATH__/golang/__VERSION__/go/bin/gofmt"

# Verificar se o binário do Go existe
if [[ ! -x "$GOFMT_BIN" ]]; then
    echo -e "\033[91m Erro: gofmt não está instalado em $GOFMT_BIN\033[0m" >&2
    echo -e "  Use \`cliverman install golang:__VERSION__\` para instalar."
    exit 1
fi

exec "$GOFMT_BIN" "$@"