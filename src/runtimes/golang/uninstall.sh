#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="$1"
readonly version="${2:-"all"}"

uninstall_all() {
    # Apagar todos os arquivos de instalação do runtime especificado
    rm -rf "${CLIVERMAN_INSTALLS_PATH:?}/${name:?}"
    
    # Apagar o arquivo current version do runtime especificado
    rm -f "${CLIVERMAN_INSTALLS_PATH:?}/current_versions/${name:?}"
    
    # Apagar todos os shims relacionados ao runtime especificado
    rm -f "${CLIVERMAN_SHIMS_PATH:?}/go"
    rm -f "${CLIVERMAN_SHIMS_PATH:?}/gofmt"

    echo -e "\033[91m ${name}:all\033[0m"
}

uninstall_version() {
    # Verificar se a versão definida é versão atual
    local current_version_path="${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"
    local current_version
    if [[ -f "${current_version_path}" ]]; then
        current_version=$(< "${current_version_path}")
    fi
    
    if [[ "$current_version" == "${version}" ]]; then
        # Apagar todos os shims relacionados ao runtime especificado
        rm -f "${CLIVERMAN_SHIMS_PATH:?}/go"
        rm -f "${CLIVERMAN_SHIMS_PATH:?}/gofmt"
        rm -f "${CLIVERMAN_INSTALLS_PATH:?}/current_versions/${name:?}"
    fi
    
    rm -rf "${CLIVERMAN_INSTALLS_PATH:?}/${name:?}/${version:?}"
    
    echo -e "\033[91m ${name}:${version}\033[0m"
}

if [[ "${version}" == "all" ]]; then
    uninstall_all name
else
    uninstall_version name version
fi

