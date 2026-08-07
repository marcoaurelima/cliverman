#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

search_runtime() {
  name="${1}"
  if ! "${CLIVERMAN_SRC_PATH}/available.sh" "${name}"; then
    echo -e "Runtime \033[96m${name}\033[0m is not supported \033[91mERROR\033[0m"
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
