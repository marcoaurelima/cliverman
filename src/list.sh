#!/bin/bash

current_versions_path="./src/current_versions"

list_all() {
  # Iterar sobre os arquivos do path e retirar a extensão do arquivo
  shopt -s nullglob
  for file in "$current_versions_path"/*; do
    local name="${file##*/}"
    if [[ -n ${name} ]]; then
      echo "· ${name%.*}"
    fi
  done
  shopt -u nullglob
}

list_runtime() {
  local name=$1
  local installs_path="./installs/${name}"
  local current_version_path="./${current_versions_path}/${name}.txt"
  local current_version
  if [[ -f ${current_version_path} ]]; then
    current_version=$(< "${current_version_path}") 
  fi

  shopt -s nullglob
  mapfile -t folders < <(printf "%s\n" "$installs_path"/* | sort -V)
  for folder in "${folders[@]}"; do
    local folder_name="${folder##*/}"
    if [[ -z ${folder_name} ]]; then
      continue 
    fi
    if [[ ${folder_name} == ${current_version} ]]; then
      echo -e "\033[0;32m· ${folder##*/} (current)\033[0m" 
      continue
    fi
    echo "· ${folder##*/}" 
  done
  shopt -u nullglob
}

if [[ "$1" == "all" ]]; then
 list_all 
 else
  list_runtime $1
fi

