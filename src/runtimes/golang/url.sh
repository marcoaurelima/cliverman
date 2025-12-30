#!/bin/bash

get_go_url() {
  local url_base="https://go.dev/dl/go"
  local version="$1"
  local os="${2:-linux}"
  local arch="${3:-amd64}"
  local format="tar.gz"
  
  echo "${url_base}${version}.${os}-$arch.${format}"
}

get_go_url $1
