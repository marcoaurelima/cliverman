#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}" 

IFS=":" read -r name version <<< "${input}"

# Verificar se o runtime solicitado está instaldo no sistema
readonly path_name="${CLIVERMAN_INSTALLS_PATH}/${name}"
if [[ ! -d "${path_name}" ]]; then
  echo -e "\033[93m Runtime [${name}] não instalado ou desconhecido.\033[0m"
  echo -e "  Nada foi alterado."
  exit 1
fi

# Verificar se a versão do runtime solicitado está uninstalado no sistema
readonly path_version="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
if [[ ! -d "${path_version}" ]]; then
  echo -e "\033[93m Versão [${name}:${version}] não instalado ou desconhecido.\033[0m"
  echo -e "  Nada foi alterado."
  exit 1
fi

echo -en "\033[0m"

"${CLIVERMAN_RUNTIMES_PATH}/${name}/uninstall.sh" "${name}" "${version}"
