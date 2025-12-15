#!/bin/bash

if [ "$1" = "all" ]; then
    echo "Listando todas as ferramentas disponíveis..."
    exit 0
elif [ "$1" = "local" ]; then
    echo "Listando todas as ferramentas instaladas..."
    exit 0
elif [ -n "$1" ]; then
    echo "Listando versões instaladas da ferramenta: $1"
    exit 0
fi
