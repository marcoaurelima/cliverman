#!/bin/bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}"
IFS=":" read -r name version <<< "$input"

# Criar script de shim
printf -v shim_script "%s\n" \
'#!/bin/bash' \
'set -e' \
'SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"' \
"exec $SCRIPT_DIR/../bin/golang/${version}/go/bin/go \$@"

# Criar arquivo de shim com permissão de execução
install -D -m 0755 /dev/stdin "${HOME}/.cliverman/shims/go" <<< "$shim_script"

# Salvar a versão atual em arquivo
# echo "$version" > $SCRIPT_DIR/../src/tools/${name}/current_version.txt
echo "$version" > $SCRIPT_DIR/../src/current_versions/${name}.txt
