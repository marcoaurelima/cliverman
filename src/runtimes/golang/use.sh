#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="${1}"
readonly version="${2}"

 # Save the current version to a file
echo "$version" > "${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"

 # Perform a full reshim to update the runtime shims and related binaries
"${CLIVERMAN_RUNTIMES_PATH}/${name}/reshim.sh" "${name}" "${version}"

echo -e "${name} v${version} \033[92mUSING\033[0m"
