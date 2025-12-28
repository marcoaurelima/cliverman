#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}"
IFS=":" read -r name version <<< "$input"

# Alias para nomear shim (exemplo: golang -> go)
readonly alias=$(< ./src/runtimes/${name}/alias.txt)

# Substituuir __VERSION__ pela versão solicitada
shim_script=$(sed "s#__VERSION__#${version}#g" ./src/runtimes/${name}/shim.sh)

# Criar arquivo de shim com permissão de execução
install -D -m 0755 /dev/stdin "${HOME}/.cliverman/shims/${alias}" <<< "$shim_script"

# Salvar a versão atual em arquivo
echo "$version" > $SCRIPT_DIR/../src/current_versions/${name}.txt
