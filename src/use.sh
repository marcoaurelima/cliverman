#!/bin/bash
# SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Sanitizar (remoção de escapes)
readonly input="${1//$'\r'/}"

# Verificar se a informação vem no formato `name:version`
if [[ "${input}" != *":"* ]]; then
  echo -e "\033[33m Versão não especificada. Use padrão \`nome:versão\` \033[0m"
  echo -e "  Nada foi alterado."
  exit 1
fi

IFS=":" read -r name version <<< "$input"

# Alias para nomear shim (exemplo: golang -> go)
readonly alias=$(< ${CLIVERMAN_RUNTIMES_PATH}/${name}/alias.txt)

# Verificar se a versão solicitada está instalada
readonly path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
if [[ ! -d "$path" ]]; then
 echo -e "\033[33m A versão ${version} ainda não foi instalada no sistema" 
 echo -e "  Use \`cliverman install ${name}:${version}\` para instalar." 
 exit 1
fi

# Substituir __VERSION__ e __INSTALLS_PATH__ no script de shim
shim_script=$(sed \
-e "s#__INSTALLS_PATH__#${CLIVERMAN_INSTALLS_PATH}#g" \
-e "s#__VERSION__#${version}#g" \
${CLIVERMAN_RUNTIMES_PATH}/${name}/shim.sh)

# Criar arquivo de shim com permissão de execução
install -D -m 0755 /dev/stdin "${CLIVERMAN_SHIMS_PATH}/${alias}" <<< "$shim_script"

# Salvar a versão atual em arquivo
echo "$version" > ${CLIVERMAN_INSTALLS_PATH}/current_versions/${name}

echo -e "\033[32m ${name} v${version}"
