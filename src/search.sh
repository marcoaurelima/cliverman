#!/usr/bin/env bash
set -e

search_runtime() {
  name="$1"
  if ! "${CLIVERMAN_SRC_PATH}/available.sh" "$name"; then
    echo "Runtime não disponível."
    return 1
  fi
  "${CLIVERMAN_RUNTIMES_PATH}/${name}/search.sh"
}

search_all() {
  "${CLIVERMAN_SRC_PATH}/available.sh"
}

if [[ "$1" == "all" ]]; then
  search_all
else
  search_runtime "$1"
fi
