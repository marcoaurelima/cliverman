#!/bin/bash

get_go_url() {
  local version="$1"
  local os="${2:-linux}"
  local arch="${3:-amd64}"
  
  url="https://go.dev/dl/go${version}.${os}-$arch.tar.gz"
  echo $url
}

get_go_url $1
