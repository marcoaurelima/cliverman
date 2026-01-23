#!/usr/bin/env bash
set -e

NPM_BIN="__INSTALLS_PATH__/nodejs/__VERSION__/node-v__VERSION__-__OS__-__ARCH__/bin/npm"

# Verificar se o binário do NPM existe
if [[ ! -x "$NPM_BIN" ]]; then
    echo -e "\033[91m Erro: npm não está instalado em $NPM_BIN\033[0m" >&2
    echo -e "  Use \`cliverman install nodejs:__VERSION__\` para instalar."
    exit 1
fi

exec "$NPM_BIN" "$@"