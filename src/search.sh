#!/bin/bash

search_runtime() {
  name="$1"
  if ! ./src/available.sh "${name}"; then
    echo "Runtime não disponível."
    return 1
  fi
  ./src/runtimes/"${name}"/search.sh
}

search_all() {
  ./src/available.sh
}

if [[ "$1" == "all" ]]; then
  search_all
else
  search_runtime "$1"
fi
