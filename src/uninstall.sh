#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Sanitize input (remove CR / carriage returns)
readonly input="${1//$'\r'/}" 

IFS=":" read -r name version <<< "${input}"

# Check if the requested runtime is installed on the system
readonly path_name="${CLIVERMAN_INSTALLS_PATH}/${name}"
if [[ ! -d "${path_name}" ]]; then
  echo -e "\033[93m Runtime [${name}] not installed or unknown.\033[0m"
  echo -e "  No changes made."
  exit 1
fi

# Check if the requested runtime version is installed on the system
readonly path_version="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
if [[ ! -d "${path_version}" ]]; then
  echo -e "\033[93m Version [${name}:${version}] not installed or unknown.\033[0m"
  echo -e "  No changes made."
  exit 1
fi

echo -en "\033[0m"

"${CLIVERMAN_RUNTIMES_PATH}/${name}/uninstall.sh" "${name}" "${version}"
