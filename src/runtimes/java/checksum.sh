#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_checksum() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)
  local arch
  arch=$("${CLIVERMAN_SRC_PATH}"/system.sh arch)
  local image_type="jdk"

  local checksum
  checksum=$(curl -s \
  "https://api.adoptium.net/v3/assets/latest/${version}/hotspot?os=${os}&architecture=${arch}&image_type=${image_type}" \
  | jq -r '.[0].binary.package.checksum')

  echo "${checksum}"
}

get_checksum "$1"
