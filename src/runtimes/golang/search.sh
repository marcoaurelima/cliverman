#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_all_versions() {
  readonly url_versions="https://go.dev/dl/?mode=json&include=all"
  mapfile -t versions < <(
    curl -fsSL "${url_versions}" | jq -r '.[] | "\(.version)\t\(.stable)"'
  )

  latest_version_index=-1
  rc_version_index=-1
  for (( i=0; i<${#versions[@]}; i++ )); do
    line="${versions[i]}"
    IFS=$'\t' read -r version stable <<< "${line}"
    if [[ "${stable}" = "true" ]]; then
      if (( latest_version_index == -1 )); then
        latest_version_index=$i
      fi
    else 
      if (( rc_version_index == -1 )); then
        rc_version_index=$i
      fi
    fi
  done
  
  for (( i=${#versions[@]}-1; i>=0; i-- )); do
    line="${versions[i]}"
    IFS=$'\t' read -r version stable <<< "${line}"
    if [ "${stable}" = "true" ]; then
      echo -en "· ${version#v}"
      if (( i == latest_version_index )); then
        echo -e " \033[1;92mLATEST\033[0m"
      else 
        echo ""
      fi
    else
      echo -en "· \033[90m${version#v}\033[0m"
      if (( i == rc_version_index )); then
        echo -e " \033[1;92mRC\033[0m"
      else 
        echo ""
      fi
    fi
  done

  aliases="$(${CLIVERMAN_RUNTIMES_PATH}/golang/aliases.sh)"
  echo -e "\n \033[1;32m${aliases} \033[0;90m(aliases)"
}

get_all_versions
