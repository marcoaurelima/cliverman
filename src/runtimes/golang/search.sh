#!/bin/bash

readonly url_versions="https://go.dev/dl/?mode=json&include=all"
mapfile -t versions < <(
  curl -fsSL $url_versions | jq -r '.[].version'
)

for (( i=${#versions[@]}-1; i>=0; i-- )); do
  echo "· ${versions[i]}"
done
  
