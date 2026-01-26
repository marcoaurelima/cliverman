#!/usr/bin/env bash
set -e

BIN_PATH="__INSTALLS_PATH__/nodejs/__VERSION__/bin/__NAME__"

if [[ -f "__SHIMS_PATH__/_RESHIM_NODEJS_" ]]; then
    echo "--- RESHIM DETECTADO ---"
    echo "cliverman reshim nodejs"
    cliverman reshim nodejs
else
    # Capturar a linha de comando completa e 
    # verificar se há comandos de instalação de pacotes
    cmd_line="$*"
    if [[ "$cmd_line" =~ (npm|yarn|pnpm|bun)[[:space:]]+(install|i|add|ci) ]] || \
    [[ "$cmd_line" =~ ^npx[[:space:]] ]]; then
        echo "🚨 Instalação detectada: $cmd_line"

        touch "__SHIMS_PATH__/_RESHIM_NODEJS_"
    fi
fi

if [[ ! -x "$BIN_PATH" ]]; then
    echo -e "\033[91m Erro: arquivo __NAME__ não encontrado.\033[0m"
    exit 1
fi

exec "$BIN_PATH" "$@"