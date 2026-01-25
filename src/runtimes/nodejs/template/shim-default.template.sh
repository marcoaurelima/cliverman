#!/usr/bin/env bash
set -e

NODEJS_BIN="__INSTALLS_PATH__/nodejs/__VERSION__/bin/__NAME__"

if [[ ! -x "$NODEJS_BIN" ]]; then
    echo -e "\033[91m Erro: nodejs __VERSION__ não está instalado ou instalação pode estar corrompida.\033[0m"
    echo -e "  Use \`cliverman install nodejs:__VERSION__\` para reinstalar."
    exit 1
fi

exec "$NODEJS_BIN" "$@"