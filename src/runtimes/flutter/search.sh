#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_all_versions() {
  readonly url_versions="https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json"
  json="$(curl -fsSL "$url_versions")"

  stable_hash="$(jq -r '.current_release.stable' <<< "$json")"
  beta_hash="$(jq -r '.current_release.beta' <<< "$json")"

  mapfile -t all_versions < <(
      jq -r '.releases | reverse | .[] | "\(.version) \(.hash)"' <<< "$json"
  )
  
  for ((i=0; i<${#all_versions[@]}; i++)); do
    IFS=" " read -r version hash <<< "${all_versions[i]}"
    printf "· %s " "${version}"

    # stable and latest versions are the same for Flutter
    if [[ "$hash" == "$stable_hash" ]]; then
      printf "\033[1;32mSTABLE LATEST\033[0m"
    elif [[ "$hash" == "$beta_hash" ]]; then
      printf "\033[1;32mBETA\033[0m"
    fi
    printf "\n"
  done

  aliases="$("${CLIVERMAN_RUNTIMES_PATH}/flutter/aliases.sh")"
  printf "\n \033[1;32m%s \033[0;90m(aliases)\n" "${aliases}"
}

get_all_versions
