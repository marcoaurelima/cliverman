#!/usr/bin/env bash
set -e

get_url() {
  local version="${1}"
  local os="${2:-linux}"
  local arch="${3:-x64}"
  local base_url="https://nodejs.org/dist"
  local format="tar.gz"

  echo "${base_url}/v${version}/node-v${version}-${os}-${arch}.${format}"
}

get_url "${1}"