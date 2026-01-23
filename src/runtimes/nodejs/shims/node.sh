#!/usr/bin/env bash
set -e

NODEJS_BIN="__INSTALLS_PATH__/nodejs/__VERSION__/node-v__VERSION__-__OS__-__ARCH__/bin/node"

# Verificar se o binário do Nodejs existe
if [[ ! -x "$NODEJS_BIN" ]]; then
    echo -e "\033[91m Erro: nodejs __VERSION__ não está instalado em $NODEJS_BIN\033[0m" >&2
    echo -e "  Use \`cliverman install nodejs:__VERSION__\` para instalar."
    exit 1
fi

exec "$NODEJS_BIN" "$@"
