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
    x86_64|x64|amd64) arch="x86_64" ;;
    x86|i386|i686)    arch="x86" ;;
    arm64|aarch64)    arch="arm64" ;;
    arm)              arch="arm" ;;
    *) ;;
  esac

  local base_url="https://github.com/neovim/neovim/releases/download/"
  local format="tar.gz"

  echo "${base_url}v${version}/nvim-${os}-${arch}.${format}"
}

get_url "${1}"

