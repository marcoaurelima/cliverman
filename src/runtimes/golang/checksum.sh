#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_checksum() {
  local version="$1"
  local os="${2:-"linux"}"
  local arch="${3:-"amd64"}"

  curl -fsSL "https://go.dev/dl/?mode=json&include=all" |  
  jq -r --arg filename "go${version}.${os}-${arch}.tar.gz" \
                       '.[].files[] | 
                        select(.filename == $filename) | 
                        .sha256'
}

get_checksum $1
