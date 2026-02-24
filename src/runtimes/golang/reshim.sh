#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly runtime_name="golang"
readonly op="${1:-}"

 # Check if there's a golang entry in current_versions
if [[ ! -f "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}" ]]; then
    exit 0
fi

runtime_version=$(< "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}")

shopt -s nullglob
 # If any installed runtime directories exist, remove old shims to avoid conflicts
install_path_golang="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/"
if [[ -d "${install_path_golang}" ]]; then
    for dir in "${install_path_golang}"*/ ; do
        if [[ -d "${dir}" ]]; then
            # Remove old shims to avoid conflicts [golang]
            bin_path_golang="${dir}bin/"
            "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" remove "" "${bin_path_golang}"
        fi
    done
fi
shopt -u nullglob

# If the operation is "remove", exit after removing shims without creating new ones
if [[ "${op}" == "remove" ]]; then
    exit 0
fi

shopt -s nullglob
 # Create shims for the active version if bin folders exist
bin_path_golang="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin/"
if [[ -d "${bin_path_golang}" ]]; then
    "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" create "${runtime_version}" "${bin_path_golang}"
fi

shopt -u nullglob
