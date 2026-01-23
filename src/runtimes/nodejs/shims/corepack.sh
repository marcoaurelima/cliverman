#!/usr/bin/env bash
set -e

COREPACK_BIN="__INSTALLS_PATH__/nodejs/__VERSION__/node-v__VERSION__-__OS__-__ARCH__/bin/corepack"

# Verificar se o binário do Nodejs existe
if [[ ! -x "$COREPACK_BIN" ]]; then
    echo -e "\033[91m Erro: Corepack não está instalado em $COREPACK_BIN\033[0m" >&2
    echo -e "  Use \`cliverman install nodejs:__VERSION__\` para instalar."
    exit 1
fi

exec "$COREPACK_BIN" "$@"
