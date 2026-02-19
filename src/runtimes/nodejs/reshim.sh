#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly runtime_name="nodejs"
 # Check if there's a nodejs entry in current_versions
if [[ ! -f "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}" ]]; then
    exit 0
fi

runtime_version=$(< "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}")

shopt -s nullglob
 # If any installed runtime directories exist, remove old shims to avoid conflicts
install_path_nodejs="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/"
if [[ -d "${install_path_nodejs}" ]]; then
    for dir in "${install_path_nodejs}"*/ ; do
        if [[ -d "${dir}" ]]; then
            # Remove old shims to avoid conflicts [node]
            bin_path_node="${dir}bin/"
            "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" remove "" "${bin_path_node}"

            # Remove old shims to avoid conflicts [yarn]
            bin_path_yarn="${bin_path_node}.yarn/bin/"
            "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" remove "" "${bin_path_yarn}"
        fi
    done
fi

 # Create shims for the active version if bin folders exist
bin_path_node="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin/"
if [[ -d "${bin_path_node}" ]]; then
    "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" create "${runtime_version}" "${bin_path_node}"
fi

 # Check .yarn/bin for Yarn binaries
bin_path_yarn="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin/.yarn/bin/"
if [[ -d "${bin_path_yarn}" ]]; then
    "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" create "${runtime_version}" "${bin_path_yarn}"
fi

shopt -u nullglob
