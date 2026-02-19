#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

list_all() {
  # Iterate over files in the path and strip the file extension
  shopt -s nullglob
  local dir="${CLIVERMAN_CURR_VERSIONS_PATH}"
  [[ -d "$dir" ]] || return 0

  for file in "$dir"/*; do
    local name="${file##*/}"
    echo "· ${name%.*}"
  done

  shopt -u nullglob
}

list_runtime() {
  local name=$1
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

