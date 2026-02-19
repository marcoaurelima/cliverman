#!/usr/bin/env bash
set -e

# Sanitize input (remove CR / carriage returns)
readonly input="${1//$'\r'/}" 

# Check if the input is in the `name:version` format
if [[ "${input}" != *":"* ]]; then
  echo -e "\033[93m Version not specified. Use format \`name:version\` \033[0m"
  echo -e "  No changes made."
  exit 1
fi

IFS=":" read -r name version <<< "${input}"

# Check if the name corresponds to an available runtime
if ! "${CLIVERMAN_SRC_PATH}/available.sh" "${name}"; then
  echo -e "\033[93m Runtime [${name}] not installed or unknown.\033[0m"
  echo -e "  No changes made."
  exit 1
fi

"${CLIVERMAN_RUNTIMES_PATH}/${name}/install.sh" "${name}" "${version}"
