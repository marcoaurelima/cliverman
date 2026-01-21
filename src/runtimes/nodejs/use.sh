#!/usr/bin/env bash
set -e

readonly name="$1"
readonly version="$2"
readonly os="${3:-linux}"
readonly arch="${4:-x64}"

install_shim() {
    local shim_name="$1"
    # Instalar shims
    shim_script=$(sed \
        -e "s#__INSTALLS_PATH__#${CLIVERMAN_INSTALLS_PATH}#g" \
        -e "s#__VERSION__#${version}#g" \
        -e "s#__OS__#${os}#g" \
        -e "s#__ARCH__#${arch}#g" \
    ${CLIVERMAN_RUNTIMES_PATH}/${name}/shims/${shim_name}.sh)

    # Criar arquivo de shim com permissão de execução
    install -D -m 0755 /dev/stdin "${CLIVERMAN_SHIMS_PATH}/${shim_name}" <<< "$shim_script"
}

install_shim "node"
install_shim "npm"
install_shim "npx"
install_shim "corepack"

# Salvar a versão atual em arquivo
echo "$version" > ${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}

echo -e "\033[92m ${name} v${version}"

