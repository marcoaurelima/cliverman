#!/usr/bin/env bash
set -e

readonly name="$1"
readonly version="$2"

install_shim() {
    local shim_type="$1"
    local shim_name="$2"
    local shim_version="$3"

    # Instalar shims
    shim_script=$("${CLIVERMAN_RUNTIMES_PATH}"/"${name}"/shim.sh "$shim_type" "$shim_name" "$shim_version")

    # Criar arquivo de shim com permissão de execução
    install -D -m 0755 /dev/stdin "${CLIVERMAN_SHIMS_PATH}/${shim_name}" <<< "$shim_script"

    # Salvar o nome dos binários em /shims/.nodejs-shims.list para controle em comando uninstall
    echo -e "${shim_name}" >> "${CLIVERMAN_SHIMS_PATH}/.nodejs-shims.list"

}

install_shim "template-default" "node" "$version"
install_shim "template-default" "npm" "$version"
install_shim "template-default" "npx" "$version"
install_shim "template-default" "corepack" "$version"

# Salvar a versão atual em arquivo
echo "$version" > "${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}"

echo -e "\033[92m ${name} v${version}"

