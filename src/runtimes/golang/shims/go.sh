#!/usr/bin/env bash
set -e

GO_BIN="__INSTALLS_PATH__/golang/__VERSION__/go/bin/go"

# Verificar se o binário do Go existe
if [[ ! -x "$GO_BIN" ]]; then
    echo -e "\033[91m Erro: go __VERSION__ não está instalado em $GO_BIN\033[0m" >&2
    echo -e "  Use \`cliverman install golang:__VERSION__\` para instalar."
    exit 1
fi

exec "$GO_BIN" "$@"