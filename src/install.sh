#!/usr/bin/env bash
set -e

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}" 

# Verificar se a informação vem no formato `name:version`
if [[ "${input}" != *":"* ]]; then
  echo -e "\033[33m Versão não especificada. Use padrão \`nome:versão\` \033[0m"
  echo -e "  Nada foi alterado."
  exit 1
fi

IFS=":" read -r name version <<< "$input"

# Verificar se o name corresponde a um runtime disponível
if ! "${CLIVERMAN_SRC_PATH}/available.sh" "${name}"; then
  echo -e "\033[33m Runtime [${name}] não instalado ou desconhecido.\033[0m"
  echo -e "  Nada foi alterado."
  exit 1
fi

${CLIVERMAN_RUNTIMES_PATH}/${name}/install.sh ${name} ${version}
