#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_all_versions() {
  readonly url_versions="https://api.github.com/repos/neovim/neovim/releases"
  mapfile -t versions < <(
    curl -fsSL "${url_versions}" | jq -r '.[] | .tag_name' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V
  )
  
  for (( i=0; i<${#versions[@]}; i++ )); do
    echo -n "· ${versions[i]#v}"
    if (( i == ${#versions[@]} - 1 )); then
      echo -e " \033[1;92mLATEST\033[0m"
    else
      echo ""
    fi
  done

  aliases="$(${CLIVERMAN_RUNTIMES_PATH}/neovim/aliases.sh)"
  echo -e "\n \033[1;32m${aliases} \033[0;90m(aliases)"
}

get_all_versions
