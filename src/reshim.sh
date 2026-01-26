#!/usr/bin/env bash
set -e

# # Sanitizar (remoção de escapes)
# readonly input="${1//$'\r'/}" 

# # Verificar se a informação vem no formato `name:version`
# if [[ "${input}" != *":"* ]]; then
#   echo -e "\033[93m Versão não especificada. Use padrão \`nome:versão\` \033[0m"
#   echo -e "  Nada foi alterado."
#   exit 1
# fi

# IFS=":" read -r name version <<< "$input"
runtime_name="$1"

"${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/reshim.sh" "${runtime_name}"