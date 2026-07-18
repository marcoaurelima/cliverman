#!/usr/bin/env bash
set -euo pipefail

readonly version="${1:-""}"
readonly params="${2:-"get"}"
readonly url_versions="https://go.dev/dl/?mode=json&include=all"

readonly alias_latest="latest"
readonly alias_rc="rc"

resolve_latest() {
    curl -fsSL "${url_versions}" \
        | jq -r '.[] | select(.stable == true) | .version' \
        | head -n1 \
        | sed 's/^go//'
}

resolve_rc() {
    curl -fsSL "${url_versions}" \
        | jq -r '.[] | select(.stable == false) | .version' \
        | head -n1 \
        | sed 's/^go//'
}

resolve_alias() {
    # If the version is not an alias, return the value.
    if [[ "$version" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$ ]]; then
        echo "$version"
        exit 0
    fi

    case "${version}" in
        "${alias_latest}") printf "%s" $(resolve_latest);;
        "${alias_rc}") printf "%s" $(resolve_rc);;
    esac
}

# Return all available nodejs aliases 
all_aliases() {
    printf "%s %s" "${alias_latest}" "${alias_rc}"
}

if [[ "${params}" == "resolve" ]]; then
    resolve_alias
else 
    all_aliases
fi