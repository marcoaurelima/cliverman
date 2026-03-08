#!/usr/bin/env bash
#set -euo pipefail
IFS=$'\n\t'

# Update Cliverman to the latest version using git pull
update_cliverman() {
  local cliverman_dir="${HOME}/.cliverman"
  if [[ -d "${cliverman_dir}/.git" ]]; then
    echo "Updating Cliverman..."
    echo -en "\033[2;97m"
    git -C "${cliverman_dir}" pull --rebase
    res=$?
    echo -en "\033[0m"
    if [[ ${res} -ne 0 ]]; then
      echo -e "Failed to update Cliverman \033[31mERROR\033[0m"
      exit 1
    fi
    echo -e "Cliverman updated  \033[32mSUCCESS\033[0m"
  else
    echo -e "Cliverman directory is not a git repository. Cannot update \033[31mERROR\033[0m"
    exit 1
  fi
}

update_cliverman