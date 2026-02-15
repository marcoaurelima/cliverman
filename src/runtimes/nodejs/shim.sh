#!/usr/bin/env bash
set -e

readonly name="$1"
readonly version="$2"
readonly default=("node" "npm" "npx" "corepack")

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

is_default=0
for shim in "${default[@]}"; do
    if [[ "$name" == "$shim" ]]; then
        is_default=1
    fi
done

if [[ "$is_default" -eq 1 ]]; then
    make_shim_nodejs_default
else
    make_shim_package_installs
fi
