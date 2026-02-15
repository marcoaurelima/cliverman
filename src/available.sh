#!/usr/bin/env bash
set -e

name=${1:-"all"}

runtimes=(
  "golang"
  "nodejs"
)

icons=(
  ""
  "󰎙"
)

list() {
  for i in "${!runtimes[@]}"; do
    echo "${icons[$i]} ${runtimes[$i]}"
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
