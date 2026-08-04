#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_all_versions() {
  readonly url_versions="https://api.adoptium.net/v3/info/available_releases"
  json="$(curl -fsSL "$url_versions")"

  mapfile -t all_versions < <(
      jq -r '.available_releases[]' <<<"$json"
  )

  mapfile -t lts_versions < <(
      jq -r '.available_lts_releases[]' <<<"$json"
  )

  j=0
  for ((i=0; i<${#all_versions[@]}; i++)); do
    (( all_versions[i] < 10 )) && echo -en "·  " || echo -en "· " 
    echo -en "${all_versions[i]} "
    if (( j < ${#lts_versions[@]} )) &&
      [[ "${all_versions[i]}" == "${lts_versions[j]}" ]]; then
      echo -en "\033[1;92mLTS\033[0m"
      ((++j))
    fi
    if (( i == ${#all_versions[@]}-1 )); then
      echo -en "\033[1;92mLATEST\033[0m"
    else 
      echo
    fi
  done
  echo
  
  aliases="$(${CLIVERMAN_RUNTIMES_PATH}/java/aliases.sh)"
  echo -e "\n \033[1;32m${aliases} \033[0;90m(aliases)"
}

get_all_versions
