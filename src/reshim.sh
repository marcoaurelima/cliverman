#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

for dir in "${CLIVERMAN_RUNTIMES_PATH}/"*/ ; do
    "${dir}reshim.sh"
done