#!/bin/bash

readonly name="$1"
readonly version="$2"
readonly url="$(./src/runtimes/${name}/url.sh ${version})"
readonly installs_path="${HOME}/.cliverman/installs/${name}/${version}"
readonly temp_path="${HOME}/.cliverman/temp/${name}_${version}.tar.gz"

# Criar pasta para binários da ferramenta
mkdir -p ${installs_path}

# Baixar para pasta temporaria de downloads
wget ${url} -O ${temp_path}

# Descompactar para pasta de binários
tar -xzf ${temp_path} -C ${installs_path}

# Remover arquivos temporarios
rm -f ${temp_path}
