#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_url() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)
  local arch
  arch=$("${CLIVERMAN_SRC_PATH}"/system.sh arch)
  local base_url="https://nodejs.org/dist"
  local format="tar.gz"

  printf "%s/v%s/node-v%s-%s-%s.%s" "${base_url}" "${version}" "${version}" "${os}" "${arch}" "${format}"
}

get_url "${1}"