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
  for ((i = 0; i < "${#runtimes[@]}"; i++)); do
    echo "${icons[$i]} ${runtimes[$i]}"
  done
}

is_valid() {
  local item="$1"

  for r in "${runtimes[@]}"; do
    if [[ "$item" == "$r" ]]; then
      return 0 
    fi
  done
  return 1
}

if [[ ${name} == "all" ]]; then
  list
  else
    is_valid "$1"
    exit
fi
