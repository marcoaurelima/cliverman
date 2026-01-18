#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}" 

IFS=":" read -r name version <<< "$input"

# Verificar se o runtime solicitado está instaldo no sistema
readonly path_name="${HOME}/.cliverman/installs/${name}"
if [[ ! -d "${path_name}" ]]; then
  echo -e "\033[33m Runtime [${name}] não instalado ou desconhecido.\033[0m"
  echo -e "  Nada foi alterado."
  exit 1
fi

# Verificar se a versão do runtime solicitado está uninstalado no sistema
readonly path_version="${HOME}/.cliverman/installs/${name}/${version}"
if [[ ! -d "${path_version}" ]]; then
  echo -e "\033[33m Versão [${name}:${version}] não instalado ou desconhecido.\033[0m"
  echo -e "  Nada foi alterado."
  exit 1
fi

echo -en "\033[0m"

$SCRIPT_DIR/runtimes/${name}/uninstall.sh ${name} ${version}
