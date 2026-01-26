#!/usr/bin/env bash

set -e

nodejs_curr_version=$(< "${CLIVERMAN_INSTALLS_PATH}/current_versions/nodejs " )

readonly runtime_name="nodejs"
readonly runtime_version="${nodejs_curr_version}"

reshim() {
    # Array para armazenar os nomes dos binários encontrados na pasta /bin do runtime
    local -a bin_names_list=()

    # Percorrer uma pasta de /bin do runtime e criar shims para cada executável
    local bin_path="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin"
    for installed_bin in "${bin_path}"/*; do
        local name
        name=$(basename "$installed_bin")

        bin_names_list+=("$name")
        
        # Verificar se o shim já existe
        if [[ -f "${CLIVERMAN_SHIMS_PATH}/${name}" ]]; then
            echo "Shim para ${name} já existe. Pulando..."
            continue
        fi

        echo "Recriando shim para ${name}..."
        # Gerar o script do shim
        local shim_script
        shim_script=$("${CLIVERMAN_RUNTIMES_PATH}/${runtime_name}/shim.sh" "template-package-installs" "$name" "$runtime_version")

        # Criar o arquivo de shim com permissão de execução
        install -D -m 0755 /dev/stdin "${CLIVERMAN_SHIMS_PATH}/${name}" <<< "$shim_script"
        
        # Salvar o nome dos binários em /shims/.nodejs-shims.list para controle em comando uninstall
        echo -e "${name}" >> "${CLIVERMAN_SHIMS_PATH}/.nodejs-shims.list"
    done

    # Percorrer a pasta de shims para verificar se há shims órfãos (sem versão instalada)
    while read -r shim_name; do
        local corresponding_bin="${CLIVERMAN_INSTALLS_PATH}/${runtime_name}/${runtime_version}/bin/${shim_name}"
        if [[ ! -f "${corresponding_bin}" ]]; then
            echo "Removendo shim órfão: ${shim_name}"
            rm -f "${CLIVERMAN_SHIMS_PATH}/${shim_name}"
        fi
    done < "${CLIVERMAN_SHIMS_PATH}/.nodejs-shims.list"
    
    # Atualizar o arquivo .nodejs-shims.list com os nomes atuais dos binários
    printf '%s\n' "${bin_names_list[@]}" > "${CLIVERMAN_SHIMS_PATH}/.nodejs-shims.list"
    
    rm -f "${CLIVERMAN_SHIMS_PATH:?}/_RESHIM_NODEJS_"
}

reshim