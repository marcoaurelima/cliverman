#!/usr/bin/env bash
set -euo pipefail

readonly version="${1:-""}"
readonly params="${2:-"get"}"
readonly url_versions="https://api.github.com/repos/neovim/neovim/releases"

readonly alias_latest="latest"

resolve_latest() {
    curl -fsSL "${url_versions}" \
    | jq -r '.[] | select(.prerelease == false) | .tag_name | ltrimstr("v")' \
    | head -n1
}

resolve_alias() {
    # If the version is not an alias, return the value.
    if [[ "$version" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$ ]]; then
        echo "$version"
        exit 0
    fi

    case "${version}" in
        "${alias_latest}") printf "%s" $(resolve_latest);;
    esac
}

# Return all available nodejs aliases 
all_aliases() {
    printf "%s" "${alias_latest}"
}

if [[ "${params}" == "resolve" ]]; then
    resolve_alias
else 
    all_aliases
fi