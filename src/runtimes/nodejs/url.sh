#!/usr/bin/env bash
set -e

get_url() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)
  local arch
  arch=$("${CLIVERMAN_SRC_PATH}"/system.sh arch)
  local base_url="https://nodejs.org/dist"
  local format="tar.gz"

  echo "${base_url}/v${version}/node-v${version}-${os}-${arch}.${format}"
}

get_url "${1}"