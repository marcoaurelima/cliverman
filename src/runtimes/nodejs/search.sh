#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_all_versions() {
  readonly url_versions="https://nodejs.org/dist/index.json"
  mapfile -t versions < <(
    curl -fsSL "${url_versions}" | jq -r '.[] | "\(.version)\t\(.lts | if . then . else "" end)"'
  )

  for (( i=${#versions[@]}-1; i>=0; i-- )); do
    line="${versions[i]}"
    IFS=$'\t' read -r version lts <<< "${line}"
    if [ -n "${lts}" ]; then
      echo -e "· ${version#v} \033[1;92mLTS \033[0;90m(${lts})\033[0m"
    else
      echo "· ${version#v}"
    fi
  done
}

get_all_versions
