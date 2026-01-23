#!/usr/bin/env bash
set -e

if [[ -z "${CLIVERMAN_PATH}" ]]; then
  export CLIVERMAN_PATH="${HOME}/.cliverman" 
fi

if [[ -z "${CLIVERMAN_SRC_PATH}" ]]; then
  export CLIVERMAN_SRC_PATH="${CLIVERMAN_PATH}/src" 
fi

if [[ -z "${CLIVERMAN_RUNTIMES_PATH}" ]]; then
  export CLIVERMAN_RUNTIMES_PATH="${CLIVERMAN_SRC_PATH}/runtimes" 
fi

if [[ -z "${CLIVERMAN_INSTALLS_PATH}" ]]; then
  export CLIVERMAN_INSTALLS_PATH="${CLIVERMAN_PATH}/installs" 
fi

if [[ -z "${CLIVERMAN_CURR_VERSIONS_PATH}" ]]; then
  export CLIVERMAN_CURR_VERSIONS_PATH="${CLIVERMAN_INSTALLS_PATH}/current_versions" 
fi

if [[ -z "${CLIVERMAN_SHIMS_PATH}" ]]; then
  export CLIVERMAN_SHIMS_PATH="${CLIVERMAN_PATH}/shims" 
fi

if [[ -z "${CLIVERMAN_TEMP_PATH}" ]]; then
  export CLIVERMAN_TEMP_PATH="${CLIVERMAN_PATH}/temp" 
fi
