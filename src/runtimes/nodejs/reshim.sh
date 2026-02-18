#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly runtime_name="nodejs"
# Verificar se existe arquivo do nodejs em current_versions
if [[ ! -f "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}" ]]; then
    exit 0
fi

runtime_version=$(< "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}")

shopt -s nullglob
# Verificar se existe pasta de /bin do runtime para criar shims dos binários do Node.JS
install_path_nodejs="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/"
if [[ -d "${install_path_nodejs}" ]]; then
    for dir in "${install_path_nodejs}"*/ ; do
        if [[ -d "${dir}" ]]; then
            # Deletar shims antigos para evitar conflitos [node]
            bin_path_node="${dir}bin/"
            "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" remove "" "${bin_path_node}"

            # Deletar shims antigos para evitar conflitos [yarn]
            bin_path_yarn="${bin_path_node}.yarn/bin/"
            "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" remove "" "${bin_path_yarn}"
        fi
    done
fi

# Verificar se existe pasta /bin para criar shims dos binários do Node.JS
bin_path_node="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin/"
if [[ -d "${bin_path_node}" ]]; then
    "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" create "${runtime_version}" "${bin_path_node}"
fi

# Verificar se existe pasta .yarn/bin para criar shims dos binários do Yarn
bin_path_yarn="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin/.yarn/bin/"
if [[ -d "${bin_path_yarn}" ]]; then
    "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" create "${runtime_version}" "${bin_path_yarn}"
fi

shopt -u nullglob
