#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_checksum() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)

  local checksum
  checksum=$(curl -s \
  "https://storage.googleapis.com/flutter_infra_release/releases/releases_${os}.json" \
  | jq -r '.releases[] | select(.version == "'"${version}"'") | .sha256' \
  )

  printf "%s" "${checksum}"
}

get_checksum "$1"
