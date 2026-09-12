#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="${1}"

# Check if the requested version is installed
readonly path="${CLIVERMAN_INSTALLS_PATH}/${name}"
if [[ ! -d "${path}" ]]; then
 printf "Runtime \033[96m%s\033[0m is not installed \033[91mERROR\033[0m\n" "${name}"
 printf "Aborted.\n"
 exit 1
fi

"${CLIVERMAN_RUNTIMES_PATH}/${name}/clear.sh"
