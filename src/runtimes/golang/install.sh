#!/bin/bash

readonly name="$1"
readonly version="$2"
readonly url="$(./src/runtimes/${name}/url.sh ${version})"
readonly installs_path="${HOME}/.cliverman/installs/${name}/${version}"
readonly temp_path="${HOME}/.cliverman/temp/${name}_${version}.tar.gz"

# Baixar para pasta temporaria de downloads
# wget -q --show-progress ${url} -O ${temp_path}
curl -L --progress-bar -o ${temp_path} ${url}

echo -n "Verificando checksum: "

# Checar o checksum do arquivo baixado
readonly checksum=$(./src/runtimes/${name}/checksum.sh ${version})

if ! echo "${checksum}  ${temp_path}" | sha256sum -c --status -; then
  echo -e "\033[31mERROR"
  echo -e "\n Checksum inválido. Abortando...\033[0m"
  # Remover arquivos temporarios
  rm -f ${temp_path}
  exit 1
  else
    echo -e "\033[32mOK\033[0m" 
fi

# Criar pasta para binários da ferramenta
mkdir -p ${installs_path}

# Descompactar para pasta de binários
tar -xzf ${temp_path} -C ${installs_path}

# Remover arquivos temporarios
rm -f ${temp_path}

echo -e "\033[32m ${name}:${version}"
