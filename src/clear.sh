#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="${1}"

# Check if the requested version is installed
readonly path="${CLIVERMAN_INSTALLS_PATH}/${name}"
if [[ ! -d "${path}" ]]; then
 echo -e "Runtime [${name}] is not installed on the system \033[91mERROR\033[0m"
 echo -e "Aborting..."
 exit 1
fi

"${CLIVERMAN_RUNTIMES_PATH}/${name}/clear.sh"