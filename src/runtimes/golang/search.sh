#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_all_versions() {
  readonly url_versions="https://go.dev/dl/?mode=json&include=all"
  mapfile -t versions < <(
    curl -fsSL "${url_versions}" | jq -r '.[] | "\(.version)\t\(.stable)"'
  )

  for (( i=${#versions[@]}-1; i>=0; i-- )); do
    line="${versions[i]}"
    IFS=$'\t' read -r version stable <<< "${line}"
    if [ "${stable}" = "true" ]; then
      echo -e "· ${version#v}"
    else
      echo -e "· \033[90m${version#v}\033[0m"
    fi
  done
}

get_all_versions
