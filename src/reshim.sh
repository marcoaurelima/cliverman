#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

for dir in "${CLIVERMAN_RUNTIMES_PATH}/"*/; do
    "${dir}reshim.sh"
    printf "· \033[2;97m%s\033[0m \033[92mRESHIMED\033[0m\n" "$(basename "${dir}")"
done
