#!/bin/bash

# Sanitizar (remoção de escapes)
input="${1//$'\r'/}" 

IFS=":" read -r name version <<< "$input"
./src/tools/${name}/install.sh ${name} ${version}
