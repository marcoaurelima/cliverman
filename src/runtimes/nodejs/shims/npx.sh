#!/usr/bin/env bash
set -e

NPX_BIN="__INSTALLS_PATH__/nodejs/__VERSION__/node-v__VERSION__-__OS__-__ARCH__/bin/npx"

# Verificar se o binário do NPX existe
if [[ ! -x "$NPX_BIN" ]]; then
    echo -e "\033[91m Erro: npx não está instalado em $NPX_BIN\033[0m" >&2
    echo -e "  Use \`cliverman install nodejs:__VERSION__\` para instalar."
    exit 1
fi

exec "$NPX_BIN" "$@"
