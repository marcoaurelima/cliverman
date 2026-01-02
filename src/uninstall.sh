#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}" 

IFS=":" read -r name version <<< "$input"
$SCRIPT_DIR/runtimes/${name}/uninstall.sh ${name} ${version}
