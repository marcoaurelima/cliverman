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

  curl -fsSL "https://api.github.com/repos/neovim/neovim/releases/tags/v${version}" |  
  jq -r --arg filename "nvim-${os}-${arch}.${format}" \
                       '.assets[] | select(.name == $filename) | .digest | ltrimstr("sha256:")'
}

get_checksum "${1}"
