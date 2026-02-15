#!/usr/bin/env bash
set -e

readonly runtime_name="nodejs"

# Verificar se existe arquivo do nodejs em current_versions
if [[ ! -f "${CLIVERMAN_INSTALLS_PATH}/current_versions/nodejs" ]]; then
    exit 0
fi

nodejs_curr_version=$(< "${CLIVERMAN_INSTALLS_PATH}/current_versions/${runtime_name}")
readonly runtime_version="${nodejs_curr_version}"

step_0()  {
    # Deletar shims existentes para evitar conflitos
    for dir in "${CLIVERMAN_INSTALLS_PATH}/nodejs/"*; do
        if [[ -d "$dir" ]]; then
           for file in "$dir"/bin/*; do
                [[ -z "$file" ]] && continue
                local bin_name
                bin_name=$(basename "$file")
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
        bin_name=$(basename "$bin")

        local shim_script
        shim_script=$("${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" "$bin_name" "$runtime_version")
        
        # Criar o arquivo de shim com permissão de execução
        install -D -m 0755 /dev/stdin "${CLIVERMAN_SHIMS_PATH}/${bin_name}" <<< "$shim_script" 
    done
}

step_0
step_1