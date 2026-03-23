#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_checksum() {
  local version="$1"
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

  local format="tar.gz"

  if [[ "$(version_to_int "${version}")" < "$(version_to_int "0.11.0")" ]]; then
    # Versions before 0.11.0 use "linux64" instead of "linux-x86_64"
    if [[ "${os}" == "linux" ]]; then
      arch="64"
    fi
    digests=$(curl -fsSL "https://github.com/neovim/neovim/releases/download/v${version}/nvim-${os}${arch}.${format}.sha256sum")
    echo "${digests}" | grep "nvim-${os}${arch}.${format}" | awk '{print $1}'
    return   
  fi

  if [[ "$(version_to_int "${version}")" < "$(version_to_int "0.11.3")" ]]; then
    digests=$(curl -fsSL "https://github.com/neovim/neovim/releases/download/v${version}/shasum.txt/")
    echo "${digests}" | grep "nvim-${os}-${arch}.${format}" | awk '{print $1}'
    return   
  fi

  curl -fsSL "https://api.github.com/repos/neovim/neovim/releases/tags/v${version}" |  
  jq -r --arg filename "nvim-${os}-${arch}.${format}" \
                       '.assets[] | select(.name == $filename) | .digest | ltrimstr("sha256:")'
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

get_checksum "${1}"

