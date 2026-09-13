#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

list_all() {
  # Check exists any runtime installed
  if [[ -z "$(find "${CLIVERMAN_INSTALLS_PATH}" \
        ! -name "current_versions" \
        ! -name ".gitkeep" \
          -mindepth 1 -print -quit 2>/dev/null)" ]]; then
    printf "No runtimes installed on the system \033[91mERROR\033[0m\n"
    printf "Aborted.\n"
    exit 1
  fi

  # Iterate over files in the path and strip the file extension
  shopt -s nullglob
  local path="${CLIVERMAN_INSTALLS_PATH}/*"
  for folder in $path; do
    local name="${folder##*/}"
    if [[ -d "${folder}" && "${name}" != "current_versions" ]]; then
      qtd=$(find "${folder}" -mindepth 1 -maxdepth 1 -type d | wc -l)
      if [[ "${qtd}" -eq 0 ]]; then
        printf "· %s\n" "${name}"
      else
        printf "· %s \033[3;90m(%s)\033[0m\n" "${name}" "${qtd}"
      fi
    fi
  done
  shopt -u nullglob
}

list_runtime() {
  local name=$1

  # Check if the requested runtime is installed on the system
  if [[ ! -d "${CLIVERMAN_INSTALLS_PATH}/${name}" ]]; then
    printf "Runtime \033[96m%s\033[0m is not installed or unknown \033[91mERROR\033[0m\n" "${name}"
    printf "Aborted.\n"
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
    [[ -L "$folder" ]] && continue
    local folder_name="${folder##*/}"
    if [[ -z ${folder_name} ]]; then
      continue 
    fi
    if [[ "${folder_name}" == "${current_version:-}" ]]; then
      printf "\033[0;92m› %s \033[0m\n" "${folder##*/}"
      continue
    fi
    printf "  %s\n" "${folder##*/}" 
  done
  shopt -u nullglob
}

if [[ "$1" == "all" ]]; then
 list_all 
 else
  list_runtime "$1"
fi

