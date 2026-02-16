#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly runtime_name="nodejs"

# Verificar se existe arquivo do nodejs em current_versions
if [[ ! -f "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}" ]]; then
    exit 0
fi

runtime_version=$(< "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}")

step_0()  {
    # Deletar shims existentes para evitar conflitos
    for dir in "${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/"*; do
        if [[ -d "${dir}" ]]; then
           for file in "${dir}"/bin/*; do
                [[ -z "${file}" ]] && continue
                local bin_name
                bin_name=$(basename "${file}")
                rm -f "${CLIVERMAN_SHIMS_PATH:?}/${bin_name:?}"
            done
        fi
    done

}

step_1() {
    # Percorrer uma pasta de /bin do runtime e criar shims para cada executável
    local bin_path="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin"
    for bin in "${bin_path}"/*; do
        local bin_name
        bin_name=$(basename "${bin}")

        "${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" "${bin_name}" "${runtime_version}"
    done
}

step_0
step_1