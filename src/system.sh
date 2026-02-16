#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_OS() {
  local os
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  echo "${os}"
}

get_arch() {
  arch="$(uname -m)"

  case "$arch" in
    x86_64 | amd64) arch="x64" ;;
    aarch64 | arm64) arch="arm64" ;;
    armv7l | armv6l) arch="arm" ;;
    i386 | i686)     arch="x86" ;;
    *)               arch="unknown" ;;
  esac
  echo "${arch}"
}

if [[ "${1}" == "os" ]]; then
  get_OS
elif [[ "${1}" == "arch" ]]; then
  get_arch
else
  exit 1
fi