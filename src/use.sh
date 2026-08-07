#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Sanitize input (remove CR / carriage returns)
readonly input="${1//$'\r'/}"

# Check if the input is in the `name:version` format
if [[ "${input}" != *":"* ]]; then
  echo -e "Version not specified. Use format \`name:version\` \033[91mERROR\033[0m"
  echo -e "Aborted."
  exit 1
fi

IFS=":" read -r name version <<< "${input}"

# Try to resolve possible version alias
version=$("${CLIVERMAN_RUNTIMES_PATH}/${name}/aliases.sh" "${version}" resolve)
readonly version

# Check if the requested version is installed
readonly path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
if [[ ! -d "${path}" ]]; then
 echo -e "Version \033[96m${version}\033[0m is not installed on the system \033[91mERROR\033[0m"
 echo -e "Aborted."
 exit 1
fi

"${CLIVERMAN_RUNTIMES_PATH}/${name}/use.sh" "${name}" "${version}"
