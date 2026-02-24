#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_url() {
  local version="${1}"
  local os
  os=$("${CLIVERMAN_SRC_PATH}"/system.sh os)
  local arch
  arch=$("${CLIVERMAN_SRC_PATH}"/system.sh arch)
  case "${arch}" in
    x86_64|x64|amd64) arch="amd64" ;;
    x86|i386|i686)    arch="386" ;;
    arm64|aarch64)   arch="arm64" ;;
    arm)              arch="armv6l" ;;
    *) ;;
  esac
  local base_url="https://go.dev/dl/go"
  local format="tar.gz"

  echo "${base_url}${version}.${os}-${arch}.${format}"
}

get_url "${1}"

