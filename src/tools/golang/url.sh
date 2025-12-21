#!/bin/bash

declare -A repositories

repositories["1.16.5"]="https://golang.org/dl/go1.16.5.linux-amd64.tar.gz"

version="$1"
echo ${repositories[$version]}


