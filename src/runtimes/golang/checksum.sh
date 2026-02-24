#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_checksum() {
  local version="$1"
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)
  local arch
  arch=$("${CLIVERMAN_SRC_PATH}"/system.sh arch)
  case "${arch}" in
    x86_64|x64|amd64) arch="amd64" ;;
    x86|i386|i686)    arch="386" ;;
    arm64|aarch64)   arch="arm64" ;;
    arm)              arch="armv6l" ;;
    *) ;;
  esac

  curl -fsSL "https://go.dev/dl/?mode=json&include=all" |  
  jq -r --arg filename "go${version}.${os}-${arch}.tar.gz" \
                       '.[].files[] | 
                        select(.filename == $filename) | 
                        .sha256'
}

get_checksum "${1}"
