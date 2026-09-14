#!/usr/bin/env bash
set -euo pipefail

readonly name="${1}"
version=$("${CLIVERMAN_RUNTIMES_PATH}/${name}/aliases.sh" "${2}" resolve)
readonly version
url="$("${CLIVERMAN_RUNTIMES_PATH}/${name}/url.sh" "${version}")"
readonly url
readonly installs_path="${CLIVERMAN_INSTALLS_PATH}/${name}/${version}"
readonly temp_path="${CLIVERMAN_TEMP_PATH}/${name}_${version}.tar.gz"

initial_verifications() {
  # Check if name and version are empty
  if [[ -z "${version}" ]]; then
    printf "\033[93mVersion not specified.\033[0m\n"
    printf "Aborted.\n"
    exit 1
  fi

  # Check if the requested version is already installed
  if [[ -d "${installs_path}" ]]; then
    printf "\033[96m%s:%s is already installed. Do you want to reinstall? [y/N] \033[0m" "${name}" "${version}"
    read -r response
    if [[ "${response}" != "y" && "${response}" != "Y" ]]; then
      printf "Aborted.\n"
      exit 1
      else
        printf "\033[96mReinstalling...\033[0m\n"
    fi
  fi
  printf "\033[0m"
}

step_0() {
  # Check if the URL (after redirects) returns HTTP 200 OK
  printf "\033[2;97m[0/4]\033[0m Checking availability of \033[2;97m%s v%s \033[0m" "${name}" "${version}"

  curl_status=0
  http_code=$(curl --head --silent --location \
   --write-out "%{http_code}" \
   --output /dev/null \
   --max-time 10 \
   "${url}") || curl_status=$?

  if [[ $curl_status -ne 0 ]]; then
    printf "\033[91mERROR\033[0m\n"
    printf "      Network error (curl exit code: %s)\n      Aborted." "${curl_status}"
    exit 1
  fi

  if [[ "$http_code" == "000" ]]; then
    printf "\033[91mERROR\033[0m\n"
    printf "      No HTTP response\n      Aborted."
    exit 1
  fi

  if [ "${http_code}" -ne 200 ]; then
    printf "\033[91mFAILED\033[0m\n"
    printf "      Version not found (HTTP %s)\n      Aborted.\033[0m" "${http_code}"
    exit 1
  fi
    
  printf "\033[92mAVAILABLE\033[0m\n" 
}

step_1() {
  
  printf "\033[2;97m[1/4]\033[0m Downloading \033[2;97m%s v%s \033[0m\n" "${name}" "${version}"
  printf "      [%s]" "${url}"

  # Try to get size (MB)
  local size_mb
  size_mb=$("${CLIVERMAN_SRC_PATH}/webutils.sh" "file-size" "${url}" || true)
  if [[ -n "${size_mb}" ]]; then
    printf " \033[90m(%s MB)\033[0m\n" "${size_mb}"
  fi

  # Baixar para pasta temporaria de downloads
  printf "\033[90m"
  curl -L -# -o "${temp_path}" "${url}"
  printf "\033[0m"
}

step_2() {
  printf "\033[2;97m[2/4]\033[0m Verifying checksum "
  
  # Check the checksum of the downloaded file
  checksum="$("${CLIVERMAN_RUNTIMES_PATH}/${name}/checksum.sh" "${version}")"

  if ! printf "%s  %s" "${checksum}" "${temp_path}" | sha256sum -c --status -; then
    printf "\033[91mERROR\033[0m\n"
    printf "      Invalid checksum. Aborted.\033[0m\n"
    # Remover arquivos temporarios
    rm -f "${temp_path:?}"
    exit 1
    else
      printf "\033[92mPASS\033[0m\n"
  fi
}

step_3() {
  printf "\033[2;97m[3/4]\033[0m Installing \033[2;97m%s v%s \033[0m\n" "${name}" "${version}"

  # Delete previous version, if it exists
  rm -rf "${installs_path:?}"
  
  # Create directory for the tool binaries
  mkdir -p "${installs_path}"

  # Unpack into the installation directory
  printf "\033[90m" 
  tar -xzf "${temp_path}" -C "${installs_path}" --strip-components=1 --checkpoint=150 --checkpoint-action='ttyout=%c'
  printf "\033[A\r\033[K"

  # Remove temporary files
  find "${CLIVERMAN_TEMP_PATH:?}" -mindepth 1 ! -name '.gitkeep' -exec rm -rf -- {} +

  printf "\033[2;97m[4/4]\033[0m \033[2;97m%s %s\033[0m \033[92mINSTALLED\033[0m\n" "${name}" "${version}"
}

initial_verifications
step_0
step_1
step_2
step_3
