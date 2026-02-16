#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}"

# Verificar se a informação vem no formato `name:version`
if [[ "${input}" != *":"* ]]; then
  echo -e "\033[93m Versão não especificada. Use padrão \`nome:versão\` \033[0m"
  echo -e "  Nada foi alterado."
  exit 1
fi

IFS=":" read -r name version <<< "${input}"

# Verificar se a versão solicitada está instalada
readonly path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
if [[ ! -d "${path}" ]]; then
 echo -e "\033[93m A versão ${version} ainda não foi instalada no sistema" 
 echo -e "  Use \`cliverman install ${name}:${version}\` para instalar." 
 exit 1
fi

"${CLIVERMAN_RUNTIMES_PATH}/${name}/use.sh" "${name}" "${version}"
