#!/usr/bin/env bash
set -e

get_all_versions() {
  readonly url_versions="https://nodejs.org/dist/index.json"
  mapfile -t versions < <(
    curl -fsSL "${url_versions}" | jq -r '.[].version'
  )

  for (( i=${#versions[@]}-1; i>=0; i-- )); do
    echo "· ${versions[i]#v}"
  done
}

get_all_versions
