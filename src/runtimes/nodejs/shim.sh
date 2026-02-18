#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly op="${1}"
readonly version="${2}"
readonly bin_path_folder="${3:-}"
readonly default=("node" "npm" "npx" "corepack")

make_shim() {
    local bin_path="${1}"
    local template="${2}"
    local name
    name=$(basename "${file}")

    shim=$(sed \
    -e "s#__BIN_PATH__#${bin_path}#g" \
    -e "s#__NAME__#${name}#g" \
    -e "s#__VERSION__#${version}#g" \
    <<< "$template")

    install -D -m 0755 /dev/stdin "${CLIVERMAN_SHIMS_PATH}/${name}" <<< "${shim}" 
}

# Função para criar o shim do Node.JS e binários pré-instados por padrão
make_shim_default() {
    local bin_path="${1}"
    local template
    template=$(< "${CLIVERMAN_RUNTIMES_PATH}/nodejs/template/shim-default.template.sh")
    make_shim "${bin_path}" "${template}"
}

# Função para criar o shim de binários instalados via PM interno (ex: npm, npx, corepack)
make_shim_package() {
    local bin_path="${1}"
    local template
    template=$(< "${CLIVERMAN_RUNTIMES_PATH}/nodejs/template/shim-packages.template.sh")
    make_shim "${bin_path}" "${template}"
}

# Função para remover os shims de acordo com os binários presentes no diretório de binários do runtime
remove_shims() {
    shopt -s nullglob
    for file in "${bin_path_folder}"*; do
        [[ -z "${file}" ]] && continue
        local bin_name
        bin_name=$(basename "${file}")
        rm -f "${CLIVERMAN_SHIMS_PATH:?}/${bin_name:?}"
    done
    shopt -u nullglob
}

create_shims() {
    shopt -s nullglob
    for file in "${bin_path_folder}"*; do
        [[ -z "${file}" ]] && continue
        local bin_name
        bin_name=$(basename "${file}")

        # Verificar se o binário é um dos binários pré-instalados por padrão para criar shim específico
        is_default=false
        for shim in "${default[@]}"; do
            if [[ "${bin_name}" == "${shim}" ]]; then
                is_default=true
                break
            fi
        done
        if [[ "${is_default}" == true ]]; then
            make_shim_default "${file}"
        else 
            make_shim_package "${file}"
        fi
    done
    shopt -u nullglob
}

if [[ "${op}" == "create" ]]; then
    create_shims
elif [[ "${op}" == "remove" ]]; then
    remove_shims
fi


