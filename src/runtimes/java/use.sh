#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly name="${1}"
readonly version="${2}"

# Save the current version to a file
echo "$version" > "${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"

# Perform a full reshim to update the runtime shims and related binaries
"${CLIVERMAN_RUNTIMES_PATH}/${name}/reshim.sh" "${name}" "${version}"

# Create a symlink to the current version of the runtime  
ln -sfn "${CLIVERMAN_INSTALLS_PATH}/${name}/${version}" "${CLIVERMAN_INSTALLS_PATH}/${name}/java_home"

# Verify is the variable JAVA_HOME is pointing to the /java_home of cliverman
if [[ "${JAVA_HOME:-}" != "${HOME}/.cliverman/installs/java/java_home" ]]; then
    echo -e "\033[91mERROR\033[0m"
    echo -e "  Please set \033[93mJAVA_HOME\033[0m to \033[93m\"\${HOME}/.cliverman/installs/java/java_home\"\033[0m\n  Aborting..."
  exit 1
fi

echo -e "${name} ${version} \033[92mUSING\033[0m"
