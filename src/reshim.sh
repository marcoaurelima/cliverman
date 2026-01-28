#!/usr/bin/env bash
set -e

for dir in "${CLIVERMAN_RUNTIMES_PATH}/"*/ ; do
    "${dir}reshim.sh"
done