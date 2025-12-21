#!/bin/bash

readonly name="$1"
readonly version="$2"
readonly url="$(./src/tools/${name}/url.sh ${version})"
readonly bin_path="${HOME}/.cliverman/bin/${name}/${version}"
readonly temp_path="${HOME}/.cliverman/temp/${name}_${version}.tar.gz"

# Criar pasta para binários da ferramenta
mkdir -p ${bin_path}

# Baixar para pasta temporaria de downloads
wget ${url} -O ${temp_path}

# Descompactar para pasta de binários
tar -xzf ${temp_path} -C ${bin_path}

# Remover arquivos temporarios
rm -f ${temp_path}
