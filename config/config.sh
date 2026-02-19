#!/usr/bin/env bash
# Global installation settings and Cliverman environment variables

if [[ -f "${CLIVERMAN_CURR_VERSIONS_PATH}/nodejs" ]]; then
  node_curr_version="$(< "${CLIVERMAN_CURR_VERSIONS_PATH}/nodejs")"
  if [[ -n "${node_curr_version}" ]]; then
    yarn config set prefix "${CLIVERMAN_INSTALLS_PATH}/nodejs/${node_curr_version}/bin/.yarn" &> /dev/null
  fi
fi

