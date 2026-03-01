#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly op="${1:-"file-size"}"
readonly url=${2:-""}

get_size_mb_from_url_curl() {
  local target="$1"
  local size_bytes
  # Follow redirects and capture the last Content-Length (case-insensitive)
  size_bytes=$(curl -sS -I -L --max-time 10 "$target" 2>/dev/null \
    | awk 'BEGIN{IGNORECASE=1} /^Content-Length:/ {val=$0} END{if (val){gsub(/\r/,"",val); split(val,a,":"); v=a[2]; gsub(/^ +| +$/,"",v); print v}}' || true)
  if [[ -n "${size_bytes}" && "${size_bytes}" =~ ^[0-9]+$ ]]; then
    awk -v b="${size_bytes}" 'BEGIN{printf "%.2f", b/1024/1024}'
  fi
}

if [[ "${op}" == "file-size" ]]; then
  get_size_mb_from_url_curl "${url}"
fi