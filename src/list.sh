#!/bin/bash

list_all() {
    tools=(
        "nodejs"
        "python"
        "ruby"
        "golang"
        "java"
        "rust"
        "php"
        "perl"
    )

    echo "  Ferramentas disponíveis para instalação:"
    for tool in "${tools[@]}"; do
        echo "  - $tool"
    done
}


list_local() {
    tools=(
        "nodejs    ∥ 14.17.0"
        "python    ∥ 3.9.1"
        "golang    ∥ 1.16.5"
    )

    versions=(
        "\033[0;32m14.17.0\033[0m"
        "3.9.1"
        "1.16.5"
    )

    echo "  Ferramentas instaladas:"
    for tool in "${tools[@]}"; do
        echo -e "  \033[0;30;47m $tool \033[0m"
        for version in "${versions[@]}"; do
        echo -e "   $version"
        done
        echo ""
    done
}

if [[ "$1" = "all" ]]; then
    list_all
    exit 0
elif [[ "$1" = "local" ]]; then
    list_local
    exit 0
elif [[ -n "$1" ]]; then
    echo "Listando versões instaladas da ferramenta: $1"
    exit 0
fi

