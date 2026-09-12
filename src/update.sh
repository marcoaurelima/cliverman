#!/usr/bin/env bash
#set -euo pipefail
IFS=$'\n\t'

# Update Cliverman to the latest version using git pull
update_cliverman() {
  if [[ -d "${CLIVERMAN_PATH}/.git" ]]; then
    echo "Updating Cliverman..."
    printf "\033[2;97m"
    git -C "${CLIVERMAN_PATH}" pull --rebase
    res=$?
    printf "\033[0m"
    if [[ ${res} -ne 0 ]]; then
      printf  "Failed to update Cliverman \033[91mERROR\033[0m\n"
      exit 1
    fi
    version=$(git -C "${CLIVERMAN_PATH}" describe --tags --abbrev=0)
    printf  "Cliverman updated (%s)  \033[92mSUCCESS\033[0m\n" "${version}"
  else
    printf  "Cliverman directory is not a git repository. Cannot update \033[91mERROR\033[0m\n"
    exit 1
  fi
}

update_cliverman
