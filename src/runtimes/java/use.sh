#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="${1}"
readonly version="${2}"

# Save the current version to a file
echo "$version" > "${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"

# Perform a full reshim to update the runtime shims and related binaries
"${CLIVERMAN_RUNTIMES_PATH}/${name}/reshim.sh" "${name}" "${version}"

# Refresh the shell command hash table so newly selected shims are recognized
rehash 2>/dev/null || hash -r 2>/dev/null || true

echo -e "${name} ${version} \033[92mUSING\033[0m"
