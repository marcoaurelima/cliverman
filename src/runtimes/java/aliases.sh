#!/usr/bin/env bash
set -euo pipefail

readonly version="${1:-""}"
readonly params="${2:-"get"}"
readonly  url_versions="https://api.adoptium.net/v3/info/available_releases"

readonly alias_latest="latest"
readonly alias_lts="lts"

resolve_latest() {
    curl -fsSL "${url_versions}" \
    | jq -r '.most_recent_feature_release'
}

resolve_lts() {
    curl -fsSL "${url_versions}" \
    | jq -r '.most_recent_lts' \
    | head -n1 \
    | sed 's/^v//'
}

resolve_alias() {
    # If the version is not an alias, return the value.
    if [[ "$version" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$ ]]; then
        echo "$version"
        exit 0
    fi

    case "${version}" in
        "${alias_latest}") printf "%s" $(resolve_latest);;
        "${alias_lts}") printf "%s" $(resolve_lts);;
    esac
}

# Return all available nodejs aliases 
all_aliases() {
    printf "%s %s" "${alias_latest}" "${alias_lts}"
}

if [[ "${params}" == "resolve" ]]; then
    resolve_alias
else 
    all_aliases
fi