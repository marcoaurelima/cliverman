#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="flutter"

printf "Cleaning %s " "${name}"

"${CLIVERMAN_RUNTIMES_PATH}/${name}/reshim.sh" remove
rm -rf "${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"

printf "\033[92mSUCCESS\033[0m\n"