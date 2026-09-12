#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_url() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)
  local arch
  arch=$("${CLIVERMAN_SRC_PATH}"/system.sh arch)
  local base_url="https://api.adoptium.net/v3/binary/latest"
  local image_type="jdk"

  printf "%s/%s/ga/%s/%s/%s/hotspot/normal/eclipse" "${base_url}" "${version}" "${os}" "${arch}" "${image_type}"
}


get_url "${1}"