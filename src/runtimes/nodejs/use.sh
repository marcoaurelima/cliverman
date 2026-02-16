#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="${1}"
readonly version="${2}"

# Salvar a versão atual em arquivo
echo "$version" > "${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"

# Fazer reshim completo para atualizar os shims do runtime e binários relacionados
"${CLIVERMAN_RUNTIMES_PATH}/${name}/reshim.sh" "${name}" "${version}"

echo -e "\033[92m ${name} v${version}"
