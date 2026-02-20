#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Sanitize input (remove CR / carriage returns)
readonly input="${1//$'\r'/}"

# Check if the input is in the `name:version` format
if [[ "${input}" != *":"* ]]; then
  echo -e "Version not specified. Use format \`name:version\` \033[91mERROR\033[0m"
  echo -e "Aborting..."
  exit 1
fi

IFS=":" read -r name version <<< "${input}"

# Check if the requested version is installed
readonly path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
if [[ ! -d "${path}" ]]; then
 echo -e "Version ${version} is not installed on the system \033[91mERROR\033[0m"
 echo -e "Aborting..."
 exit 1
fi

"${CLIVERMAN_RUNTIMES_PATH}/${name}/use.sh" "${name}" "${version}"
