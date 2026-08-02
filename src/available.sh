#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

name=${1:-"all"}

runtimes=(
  "golang"
  "java"
  "neovim"
  "nodejs"
)

icons=(
  ""
  ""
  ""
  "󰎙"
)

list() {
  for i in "${!runtimes[@]}"; do
    echo " ${icons[$i]} ${runtimes[$i]}"
  done
}

is_valid() {
  for runtime in "${runtimes[@]}"; do
    if [[ "${name}" == "${runtime}" ]]; then
      return 0 
    fi
  done
  return 1
}

if [[ ${name} == "all" ]]; then
  list
  else
    is_valid "${name}"
    exit $?
fi
