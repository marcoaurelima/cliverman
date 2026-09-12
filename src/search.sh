#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

search_runtime() {
  name="${1}"
  if ! "${CLIVERMAN_SRC_PATH}/available.sh" "${name}"; then
    printf "Runtime \033[96m%s\033[0m is not supported \033[91mERROR\033[0m\n" "${name}"
    return 1
  fi
  "${CLIVERMAN_RUNTIMES_PATH}/${name}/search.sh"
}

search_all() {
  "${CLIVERMAN_SRC_PATH}/available.sh"
}

if [[ "${1}" == "all" ]]; then
  search_all
else
  search_runtime "${1}"
fi
