#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="$1"
readonly version="${2:-"all"}"

uninstall_all() {
    # Verificar se existe pasta de /bin do runtime para criar shims dos binários do Node.JS
    shopt -s nullglob
    install_path_nodejs="${CLIVERMAN_INSTALLS_PATH}/${name}/"
    if [[ -d "${install_path_nodejs}" ]]; then
        for dir in "${install_path_nodejs}"*/ ; do
            if [[ -d "${dir}" ]]; then
                # Deletar shims antigos para evitar conflitos [node]
                bin_path_node="${dir}bin/"
                "${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh" remove "" "${bin_path_node}"

                # Deletar shims antigos para evitar conflitos [yarn]
                bin_path_yarn="${bin_path_node}.yarn/bin/"
                "${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh" remove "" "${bin_path_yarn}"
            fi
        done
    fi

    # Verificar se existe pasta .yarn/bin para criar shims dos binários do Yarn
    bin_path_yarn="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}/.yarn/bin/"
    "${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh" remove "" "${bin_path_yarn}"

    # Apagar todos os arquivos de instalação do runtime especificado
    rm -rf "${CLIVERMAN_INSTALLS_PATH:?}/${name:?}"
    rm -f "${CLIVERMAN_INSTALLS_PATH:?}/current_versions/${name:?}"
    echo -e "\033[91m ${name}\033[0m"
}

uninstall_version() {
    # Verificar se a versão definida é versão atual
    local current_version_path="${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"
    local current_version
    if [[ -f "${current_version_path}" ]]; then
        current_version=$(< "${current_version_path}")
    fi

    shopt -s nullglob
    if [[ "$current_version" == "${version}" ]]; then
        local bin_path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}/bin"
        "${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh" remove "" "${bin_path}"
        rm -f "${CLIVERMAN_INSTALLS_PATH:?}/current_versions/${name:?}"
    fi
    shopt -u nullglob
    
    rm -rf "${CLIVERMAN_INSTALLS_PATH:?}/${name:?}/${version:?}"
    echo -e "\033[91m ${name}:${version}\033[0m"
}

if [[ "${version}" == "all" ]]; then
    uninstall_all
else
    uninstall_version
fi

