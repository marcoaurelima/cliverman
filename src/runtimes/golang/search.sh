#!/bin/bash
mapfile -t versions < <(
  curl -fsSL "https://go.dev/dl/?mode=json&include=all" | jq -r '.[].version'
)

for (( i=${#versions[@]}-1; i>=0; i-- )); do
  echo "· ${versions[i]}"
done
  
