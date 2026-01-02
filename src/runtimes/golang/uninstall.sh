#!/bin/bash

readonly name="$1"
readonly version="${2:-"all"}"

uninstall_all() {
  # Apagar todos os arquivos de instalação do runtime especificado
  rm -rf "./installs/${name}"

  # Apagar o arquivo current version do runtime especificado
  rm -f "./src/current_versions/${name}.txt"

  # Apagar o shim do runtime especificado
  local shim_alias=$(< "./src/runtimes/${name}/alias.txt")
  rm -f "./shims/${shim_alias}"

  echo -e "\033[31m ${name}:all\033[0m"
}

uninstall_version() {
  # Verificar se a versão definida é versão atual
  local current_version_path="./src/current_versions/${name}.txt"
  local current_version
  if [[ -f "${current_version_path}" ]]; then
    current_version=$(< "${current_version_path}")
  fi

  if [[ "$current_version" == "${version}" ]]; then
    local shim_alias=$(< "./src/runtimes/${name}/alias.txt")
    rm -f "./shims/${shim_alias}"
    rm -f "./src/current_versions/${name}.txt"
  fi
  
  rm -rf "./installs/${name}/${version}"

  echo -e "\033[31m ${name}:${version}\033[0m"
}

if [[ "${version}" == "all" ]]; then
  uninstall_all name
  else
    uninstall_version name version
fi

