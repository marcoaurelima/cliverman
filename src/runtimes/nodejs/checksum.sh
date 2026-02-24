#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_checksum() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)
  local arch
  arch=$("${CLIVERMAN_SRC_PATH}"/system.sh arch)

  curl -fsSL "https://nodejs.org/dist/v${version}/SHASUMS256.txt" |
  grep "node-v${version}-${os}-${arch}.tar.gz" |
  awk '{print $1}'
}

get_checksum "$1"
