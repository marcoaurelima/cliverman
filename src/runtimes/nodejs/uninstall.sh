#!/usr/bin/env bash
set -e

readonly name="$1"
readonly version="${2:-"all"}"

uninstall_all() {
    # Deletar shims para cada executável presente em todas as instalações
    for dir in "${CLIVERMAN_INSTALLS_PATH}/nodejs/"*; do
        if [[ -d "$dir" ]]; then
           for file in "$dir"/bin/*; do
                [[ -z "$file" ]] && continue
                local bin_name
                bin_name=$(basename "$file")
                rm -f "${CLIVERMAN_SHIMS_PATH:?}/${bin_name:?}"
            done
        fi
    done

    # Apagar todos os arquivos de instalação do runtime especificado
    rm -f "${CLIVERMAN_INSTALLS_PATH:?}/${name:?}"
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
    
    if [[ "$current_version" == "${version}" ]]; then
        local bin_path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}/bin"
        for bin in "${bin_path}"/*; do
            local bin_name
            bin_name=$(basename "$bin")
            rm -f "${CLIVERMAN_SHIMS_PATH:?}/${bin_name:?}"
        done

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

