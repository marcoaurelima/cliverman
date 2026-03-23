#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly runtime_name="neovim"
readonly op="${1:-}"

 # Check if there's a neovim entry in current_versions
if [[ ! -f "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}" ]]; then
    exit 0
fi

runtime_version=$(< "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}")

shopt -s nullglob
 # If any installed runtime directories exist, remove old shims to avoid conflicts
install_path_neovim="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/"
if [[ -d "${install_path_neovim}" ]]; then
    for dir in "${install_path_neovim}"*/ ; do
        if [[ -d "${dir}" ]]; then
            # Remove old shims to avoid conflicts [neovim]
            bin_path_neovim="${dir}bin/"
            "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" remove "${bin_path_neovim}"
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
bin_path_neovim="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin/"
if [[ -d "${bin_path_neovim}" ]]; then
    "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" create "${bin_path_neovim}" "${runtime_version}"
fi
shopt -u nullglob
