#!/usr/bin/env bash

set -e

readonly shim_type="$1"
readonly name="$2"
readonly version="$3"

# Função para criar o shim do Node.JS e binários pré-instados por padrão
make_shim_nodejs_default() {
    local template
    template=$(< "${CLIVERMAN_RUNTIMES_PATH}/nodejs/template/shim-default.template.sh")

    sed \
    -e "s#__INSTALLS_PATH__#${CLIVERMAN_INSTALLS_PATH}#g" \
    -e "s#__NAME__#${name}#g" \
    -e "s#__VERSION__#${version}#g" \
    <<< "$template"
}

# Função para criar o shim de binários instalados via npm (ex: npm, npx, corepack)
make_shim_package_installs() {
    local template
    template=$(< "${CLIVERMAN_RUNTIMES_PATH}/nodejs/template/shim-packages.template.sh")

    sed \
    -e "s#__INSTALLS_PATH__#${CLIVERMAN_INSTALLS_PATH}#g" \
    -e "s#__NAME__#${name}#g" \
    -e "s#__VERSION__#${version}#g" \
    <<< "$template"
}

if [[ "$shim_type" == "template-default" ]]; then
    make_shim_nodejs_default 
elif [[ "$shim_type" == "template-package-installs" ]]; then
    make_shim_package_installs
fi