#!/usr/bin/env bash
set -euo pipefail

readonly name="$1"
readonly version="$2"
url="$("${CLIVERMAN_RUNTIMES_PATH}/${name}/url.sh" "$version")"
readonly url

readonly installs_path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
readonly temp_path="${CLIVERMAN_TEMP_PATH}/${name}_${version}.tar.gz"

initial_verifications() {
  # Verificar se name e version estão vazios
  if [[ -z "${version}" ]]; then
    echo -e "\033[93m Versão não especificada.\033[0m"
    echo -e "  Nada foi alterado."
    exit 1
  fi

  # Verificar se a versão requerida já está instalada
  if [[ -d "${installs_path}" ]]; then
    echo -en "\033[96m ${name} v${version} já está instalado. Deseja reinstalar? [s/N] \033[0m"
    read response
    if [[ $response != "s" && $response != "S" ]]; then
      echo "  Nada foi alterado." 
      exit 1
      else
        echo "  Reinstalando..."
    fi
  fi
  echo -en "\033[0m"
}

step_0() {
   # Verificar se a URL (após redirecionamentos) retorna HTTP 200 OK
  echo -n "[0/3] Verificando disponibilidade de ${name} v${version} "

  http_code=$(curl --head --silent --location \
   --write-out "%{http_code}" \
   --output /dev/null \
   --max-time 10 \
   "$url")

  if [ "$http_code" -ne 200 ]; then
   echo -e "\033[93mUNAVAILABLE\033[0m"
   echo -e "\033[91m  Versão não encontrada (HTTP $http_code)\n   Abortando...\033[0m"
   exit 1
   else
     echo -e "\033[92mAVAILABLE\033[0m"
  fi
}

step_1() {
  echo "[1/3] Baixando ${name} v${version}"
  echo "      [${url}]"

  # Baixar para pasta temporaria de downloads
  echo -en "\033[90m"
  curl -L --progress-bar -o ${temp_path} ${url}
  echo -en "\033[0m"
}

step_2() {
  echo -n "[2/3] Verificando checksum "
  
  # Checar o checksum do arquivo baixado
  checksum="$("${CLIVERMAN_RUNTIMES_PATH}/${name}/checksum.sh" "${version}")"
  readonly checksum

  if ! echo "${checksum}  ${temp_path}" | sha256sum -c --status -; then
   echo -e "\033[91mERROR"
    echo -e "\n Checksum inválido. Abortando...\033[0m"
    # Remover arquivos temporarios
    rm -f "${temp_path}"
    exit 1
    else
      echo -e "\033[92mPASS\033[0m" 
  fi
}

step_3() {
  echo "[3/3] Instalando ${name} v${version}"

  # Criar pasta para binários da ferramenta
  mkdir -p "${installs_path}"

  # Descompactar para pasta de binários
  tar -xzf "${temp_path}" -C "${installs_path}"

  # Remover arquivos temporarios
  rm -f "${temp_path}"

  echo -e "\033[92m ${name} v${version} instalado com sucesso!"
}

initial_verifications
step_0
step_1
step_2
step_3
