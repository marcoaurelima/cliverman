#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="nodejs"

echo -en "Cleaning ${name} "

"${CLIVERMAN_RUNTIMES_PATH}/${name}/reshim.sh" remove
rm -rf "${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"

echo -e "\033[92mSUCCESS\033[0m"