#!/bin/bash

current_versions_path="./src/current_versions"

list_all() {

  #Iterar sobre os arquivos do path e retirar a extensão do arquivo
  for file in "$current_versions_path"/*; do
    local name="${file##*/}"
    # version=$(< ${current_versions_path}/${name})
    echo "· ${name%.*}"
  done
}

list_runtime() {
  # echo "saida do comando list runtime_name"
  local name=$1
  local installs_path="./installs/${name}"
  local current_version=$(< ./${current_versions_path}/${name}.txt)

  for folder in "$installs_path"/*; do
    if [[ ${folder##*/} == ${current_version} ]]; then
      echo -e "\033[0;32m· ${folder##*/} (current)\033[0m" 
      continue
    fi
    echo "· ${folder##*/}" 
  done

  # echo ">>> ${current_version}"
  # ls ${installs_path}
}

if [[ "$1" == "all" ]]; then
 list_all 
 else
  list_runtime $1
fi

# list_all() {
#     tools=(
#         "󰟓 golang"
#         "java"
#     )
#
#     echo "  Ferramentas disponíveis para instalação:"
#     for tool in "${tools[@]}"; do
#         echo "  - $tool"
#     done
# }
#
#
# list_local() {
#     tools=(
#         "nodejs    ∥ 14.17.0"
#         "python    ∥ 3.9.1"
#         "golang    ∥ 1.16.5"
#     )
#
#     versions=(
#         "\033[0;32m14.17.0\033[0m"
#         "3.9.1"
#         "1.16.5"
#     )
#
#     echo "  Ferramentas instaladas:"
#     for tool in "${tools[@]}"; do
#         echo -e "  \033[0;30;47m $tool \033[0m"
#         for version in "${versions[@]}"; do
#         echo -e "   $version"
#         done
#         echo ""
#     done
# }
#
# if [[ "$1" = "all" ]]; then
#     list_all
#     exit 0
# elif [[ "$1" = "local" ]]; then
#     list_local
#     exit 0
# elif [[ -n "$1" ]]; then
#     echo "Listando versões instaladas da ferramenta: $1"
#     exit 0
# fi
#
