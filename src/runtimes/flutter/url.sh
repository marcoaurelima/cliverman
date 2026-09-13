#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_url() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)

  json="$(curl -fsSL "https://storage.googleapis.com/flutter_infra_release/releases/releases_${os}.json")"

  base_url="$(jq -r '.base_url' <<< "${json}")"
  printf "%s/%s" "${base_url}" "$(jq -r --arg version "${version}" '.releases[] | select(.version == $version) | .archive' <<< "${json}")"
}

get_url "${1}"