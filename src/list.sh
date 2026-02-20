#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

list_all() {
  # Check exists any runtime installed
  if [[ -z "$(find "${CLIVERMAN_INSTALLS_PATH}" \
        ! -name "current_versions" \
        ! -name ".gitkeep" \
          -mindepth 1 -print -quit 2>/dev/null)" ]]; then
    echo -e "No runtimes installed on the system \033[91mERROR\033[0m"
    echo -e "Aborting..."
    exit 1
  fi

  # Iterate over files in the path and strip the file extension
  shopt -s nullglob
  local path="${CLIVERMAN_INSTALLS_PATH}/*"
  for folder in $path; do
    local name="${folder##*/}"
    if [[ -d "${folder}" && "${name}" != "current_versions" ]]; then
      echo "· ${name}"
    fi
  done
  shopt -u nullglob
}

list_runtime() {
  local name=$1

  # Check if the requested runtime is installed on the system
  if [[ ! -d "${CLIVERMAN_INSTALLS_PATH}/${name}" ]]; then
    echo -e "Runtime [${name}] not installed or unknown \033[91mERROR\033[0m"
    echo -e "Aborting..."
    exit 1
  fi

  local install_path="${CLIVERMAN_INSTALLS_PATH}/${name}"
  local current_version_path="${CLIVERMAN_CURR_VERSIONS_PATH}/${name}"
  local current_version
  if [[ -f "${current_version_path}" ]]; then
    current_version=$(< "${current_version_path}") 
  fi

  shopt -s nullglob
  mapfile -t folders < <(printf "%s\n" "$install_path"/* | sort -V)
  for folder in "${folders[@]}"; do
    local folder_name="${folder##*/}"
    if [[ -z ${folder_name} ]]; then
      continue 
    fi
    if [[ "${folder_name}" == "${current_version:-}" ]]; then
      echo -e "\033[0;92m· ${folder##*/} (current)\033[0m" 
      continue
    fi
    echo "· ${folder##*/}" 
  done
  shopt -u nullglob
}

if [[ "$1" == "all" ]]; then
 list_all 
 else
  list_runtime "$1"
fi

