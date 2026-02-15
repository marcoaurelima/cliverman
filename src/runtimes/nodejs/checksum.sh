#!/usr/bin/env bash
set -e

get_checksum() {
  local version="${1}"
  local os="${2:-"linux"}"
  local arch="${3:-"x64"}"

  echo "[debug-cksum] node-v${version}-${os}-${arch}.tar.gz"

  curl -fsSL "https://nodejs.org/dist/v${version}/SHASUMS256.txt" |
  grep "node-v${version}-${os}-${arch}.tar.gz" |
  awk '{print $1}'
}

get_checksum "$1"
