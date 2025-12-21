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

# Criação de shim
echo -e "#!/bin/bash\nexec ./bin/${name}/${version}/go/bin/go \"\$@\"" > ./shims/go

# wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz -O /tmp/go1.16.5.linux-amd64.tar.gz
# mkdir -p ./bin/golang/1.16.5
# sudo tar -C ./bin/golang/1.16.5 -xzf /tmp/go1.16.5.linux-amd64.tar.gz
# rm /tmp/go1.16.5.linux-amd64.tar.gz
