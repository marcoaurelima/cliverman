#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Sanitize input (remove CR / carriage returns)
readonly input="${1//$'\r'/}" 

IFS=":" read -r name version <<< "${input}"

# If version is non-empty, try to resolve possible version alias
if [[ -n "${version}" ]]; then
  version=$("${CLIVERMAN_RUNTIMES_PATH}/${name}/aliases.sh" "${version}" resolve)
  readonly version
fi

# Check if the requested runtime is installed on the system
readonly path_name="${CLIVERMAN_INSTALLS_PATH}/${name}"
if [[ ! -d "${path_name}" ]]; then
  printf  "Runtime \033[96m%s\033[0m is not installed \033[91mERROR\033[0m\n" "${name}"
  printf  "Aborted.\n"
  exit 1
fi

# Check if the requested runtime version is installed on the system
readonly path_version="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
if [[ ! -d "${path_version}" ]]; then
  printf  "Runtime \033[96m%s:%s\033[0m is not installed \033[91mERROR\033[0m\n" "${name}" "${version}"
  printf  "Aborted.\n"
  exit 1
fi

printf "\033[0m"
"${CLIVERMAN_RUNTIMES_PATH}/${name}/uninstall.sh" "${name}" "${version}"
