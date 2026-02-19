#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Sanitize input (remove CR / carriage returns)
readonly input="${1//$'\r'/}"

# Check if the input is in the `name:version` format
if [[ "${input}" != *":"* ]]; then
  echo -e "\033[93m Version not specified. Use format \`name:version\` \033[0m"
  echo -e "  No changes made."
  exit 1
fi

IFS=":" read -r name version <<< "${input}"

# Check if the requested version is installed
readonly path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
if [[ ! -d "${path}" ]]; then
 echo -e "\033[93m Version ${version} is not installed on the system" 
 echo -e "  Use \`cliverman install ${name}:${version}\` to install." 
 exit 1
fi

"${CLIVERMAN_RUNTIMES_PATH}/${name}/use.sh" "${name}" "${version}"
