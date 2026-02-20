#!/usr/bin/env bash
set -euo pipefail

readonly name="${1}"
readonly version="${2}"
url="$("${CLIVERMAN_RUNTIMES_PATH}/${name}/url.sh" "${version}")"
readonly url
readonly installs_path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
readonly temp_path="${CLIVERMAN_TEMP_PATH}/${name}_${version}.tar.gz"

initial_verifications() {
  # Check if name and version are empty
  if [[ -z "${version}" ]]; then
    echo -e "\033[93m Version not specified.\033[0m"
    echo -e "  No changes made."
    exit 1
  fi

  # Check if the requested version is already installed
  if [[ -d "${installs_path}" ]]; then
    echo -en "\033[96m${name} v${version} is already installed. Do you want to reinstall? [y/N] \033[0m"
    read -r response
    if [[ "${response}" != "y" && "${response}" != "Y" ]]; then
      echo "Aborting..." 
      exit 1
      else
        echo -e "\033[96mReinstalling...\033[0m"
    fi
  fi
  echo -en "\033[0m"
}

step_0() {
  # Check if the URL (after redirects) returns HTTP 200 OK
  echo -n "[0/3] Checking availability of ${name} v${version} "

  http_code=$(curl --head --silent --location \
   --write-out "%{http_code}" \
   --output /dev/null \
   --max-time 10 \
   "${url}")

   if [ "${http_code}" -ne 200 ]; then
   echo -e "\033[93mUNAVAILABLE\033[0m"
   echo -e "\033[91mVersion not found (HTTP ${http_code})\nAborting...\033[0m"
   exit 1
   else
     echo -e "\033[92mAVAILABLE\033[0m"
  fi
}

step_1() {
  echo "[1/3] Downloading ${name} v${version}"
  echo "      [${url}]"

  # Baixar para pasta temporaria de downloads
  echo -en "\033[90m"
  curl -L --progress-bar -o "${temp_path}" "${url}"
  echo -en "\033[0m"
}

step_2() {
  echo -n "[2/3] Verifying checksum "
  
  # Check the checksum of the downloaded file
  checksum="$("${CLIVERMAN_RUNTIMES_PATH}/${name}/checksum.sh" "${version}")"

  if ! echo "${checksum}  ${temp_path}" | sha256sum -c --status -; then
    echo -e "\033[91mERROR"
    echo -e "\nInvalid checksum. Aborting...\033[0m"
    # Remover arquivos temporarios
    rm -f "${temp_path:?}"
    exit 1
    else
      echo -e "\033[92mPASS\033[0m" 
  fi
}

step_3() {
  echo "[3/3] Installing ${name} v${version}"

  # Delete previous version, if it exists
  rm -rf "${installs_path:?}"
  
  # Create directory for the tool binaries
  mkdir -p "${installs_path}"

  # Unpack into the installation directory
  tar -xzf "${temp_path}" -C "${installs_path}" --strip-components=1

  # Remove temporary files
  rm -f "${temp_path:?}"

  echo -e "      ${name} v${version} \033[92mINSTALLED"
}

initial_verifications
step_0
step_1
step_2
step_3
