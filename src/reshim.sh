#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

for dir in "${CLIVERMAN_RUNTIMES_PATH}/"*/; do
    "${dir}reshim.sh"
    echo -e "· \033[2;97m$(basename "${dir}")\033[0m \033[92mRESHIMED\033[0m"
done