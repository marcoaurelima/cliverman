#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_url() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)
  local arch
  arch=$("${CLIVERMAN_SRC_PATH}"/system.sh arch)
  case "${arch}" in
    x86_64|x64|amd64) arch="x86_64" ;;
    x86|i386|i686)    arch="x86" ;;
    arm64|aarch64)    arch="arm64" ;;
    arm)              arch="arm" ;;
    *) ;;
  esac

  local base_url="https://github.com/neovim/neovim/releases/download/"
  local format="tar.gz"

  if [[ "$(version_to_int "${version}")" < "$(version_to_int "0.11.0")" ]]; then
    # For versions before 0.11.0, the nomeclature is linux64
    if [[ "${os}" == "linux" ]]; then
      arch="64"
    fi  

    echo "${base_url}v${version}/nvim-${os}${arch}.${format}"
    return
  fi

  echo "${base_url}v${version}/nvim-${os}-${arch}.${format}"
}

version_to_int() {
    local IFS=.
    local major minor patch
    read -r major minor patch <<< "$1"

    printf "%03d%03d%03d\n" \
        "${major:-0}" \
        "${minor:-0}" \
        "${patch:-0}"
}


get_url "${1}"

