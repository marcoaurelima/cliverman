#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}"
IFS=":" read -r name version <<< "$input"

# Alias para nomear shim (exemplo: golang -> go)
readonly alias=$(< ./src/runtimes/${name}/alias.txt)

# Verificar se a versão solicitada está instalada
readonly path="./installs/${name}/${version}"
if [[ ! -d "$path" ]]; then
 echo -e "\033[33m A versão ${version} ainda não foi instalada no sistema" 
 echo -e "  Use \`cliverman install ${name}:${version}\` para instalar." 
fi

# Substituuir __VERSION__ pela versão solicitada
shim_script=$(sed "s#__VERSION__#${version}#g" ./src/runtimes/${name}/shim.sh)

# Criar arquivo de shim com permissão de execução
install -D -m 0755 /dev/stdin "${HOME}/.cliverman/shims/${alias}" <<< "$shim_script"

# Salvar a versão atual em arquivo
echo "$version" > $SCRIPT_DIR/../src/current_versions/${name}.txt
