#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="$1"
readonly version="${2:-"all"}"

uninstall_all() {
    # If any installed runtime directories exist, remove old shims to avoid conflicts
    shopt -s nullglob
    install_path_nodejs="${CLIVERMAN_INSTALLS_PATH}/${name}/"
    if [[ -d "${install_path_nodejs}" ]]; then
        for dir in "${install_path_nodejs}"*/ ; do
            if [[ -d "${dir}" ]]; then
                # Remove old shims to avoid conflicts [node]
                bin_path_node="${dir}bin/"
                "${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh" remove "" "${bin_path_node}"

                # Remove old shims to avoid conflicts [yarn]
                bin_path_yarn="${bin_path_node}.yarn/bin/"
                "${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh" remove "" "${bin_path_yarn}"
            fi
        done
    fi

    # Remove .yarn/bin shims for Yarn binaries
    bin_path_yarn="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}/.yarn/bin/"
    "${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh" remove "" "${bin_path_yarn}"

    # Remove all installation files for the specified runtime
    rm -rf "${CLIVERMAN_INSTALLS_PATH:?}/${name:?}"
    rm -f "${CLIVERMAN_INSTALLS_PATH:?}/current_versions/${name:?}"
    echo -e "${name} \033[93mUNINSTALLED\033[0m"
}

uninstall_version() {
    local current_version_path="${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"
    if [[ -f "${current_version_path}" ]]; then
        # Check if the defined version is the current version
        local current_version
        if [[ -f "${current_version_path}" ]]; then
            current_version=$(< "${current_version_path}")
        fi

        shopt -s nullglob
        if [[ "${current_version}" == "${version}" ]]; then
            local bin_path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}/bin"
            "${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh" remove "" "${bin_path}"
            rm -f "${CLIVERMAN_INSTALLS_PATH:?}/current_versions/${name:?}"
        fi
        shopt -u nullglob
    fi
    
    rm -rf "${CLIVERMAN_INSTALLS_PATH:?}/${name:?}/${version:?}"
    # If the runtime folder is empty after removing the version, remove it as well
    local runtime_path="${CLIVERMAN_INSTALLS_PATH}/${name}"
    if [[ -d "${runtime_path}" && -z "$(ls -A "${runtime_path}")" ]]; then
        rm -rf "${runtime_path}"
    fi
    echo -e "${name} v${version} \033[93mUNINSTALLED\033[0m"
}

if [[ "${version}" == "all" ]]; then
    uninstall_all
else
    uninstall_version
fi

