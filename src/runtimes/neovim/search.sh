#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_all_versions() {
  readonly url_versions="https://api.github.com/repos/neovim/neovim/releases"
  mapfile -t versions < <(
    curl -fsSL "${url_versions}" | jq -r '.[] | .tag_name' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V
  )
  
  for version in "${versions[@]}"; do
    echo "· ${version#v}"
  done
}

get_all_versions
