#!/usr/bin/env bash
set -euo pipefail

readonly version="${1:-""}"
readonly params="${2:-"get"}"
readonly url_versions="https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json"

readonly alias_stable="stable"
readonly alias_beta="beta"
readonly alias_latest="latest"

resolve_stable() {
    json="$(curl -fsSL "${url_versions}")"
    hash="$(jq -r '.current_release.stable' <<< "${json}")"

   jq -r --arg hash "${hash}" '.releases[] | select(.hash == $hash) | .version' <<< "${json}"
}

resolve_beta() {
    json="$(curl -fsSL "${url_versions}")"
    hash="$(jq -r '.current_release.beta' <<< "${json}")"

   jq -r --arg hash "${hash}" '.releases[] | select(.hash == $hash) | .version' <<< "${json}"
}

resolve_latest() {
    resolve_stable
}

resolve_alias() {
    #printf "4444 %s\n" "${version}"
    # If the version is not an alias, return the value.
    if [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+([.-][0-9A-Za-z.]+)*$ ]]; then
        printf "%s" "$version"
        exit 0
    fi

    case "${version}" in
        "${alias_stable}") printf "%s" "$(resolve_stable)";;
        "${alias_beta}") printf "%s" "$(resolve_beta)";;
        "${alias_latest}") printf "%s" "$(resolve_latest)";;
    esac
}

# Return all available flutter aliases 
all_aliases() {
    printf "%s %s %s" "${alias_stable}" "${alias_beta}" "${alias_latest}"
}

if [[ "${params}" == "resolve" ]]; then
    resolve_alias
else 
    all_aliases
fi