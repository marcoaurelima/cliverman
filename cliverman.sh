#!/usr/bin/env bash
# set -euo pipefail
# IFS=$'\n\t'

# Load Cliverman environment variables
# shellcheck disable=SC1091
source "${HOME}/.cliverman/config/env.sh"

readonly CLIVERMAN_VERSION=$(git -C ${CLIVERMAN_PATH} describe --tags --abbrev=0)

if [[ "$#" -eq 2 ]]; then
    if [[ "${1}" == "list" || "${1}" == "l" ]]; then
        "${CLIVERMAN_SRC_PATH}/list.sh" "${2}"
        exit 0
    elif [[ "${1}" == "install" || "${1}" == "i" ]]; then 
        "${CLIVERMAN_SRC_PATH}/install.sh" "${2}"
        exit 0
    elif [[ "${1}" == "use" || "${1}" == "u" ]]; then 
        "${CLIVERMAN_SRC_PATH}/use.sh" "${2}"
        exit 0
    elif [[ "${1}" == "search" || "${1}" == "s" ]]; then
        "${CLIVERMAN_SRC_PATH}/search.sh" "${2}"
        exit 0
    elif [[ "${1}" == "clear" || "${1}" == "c" ]]; then
        "${CLIVERMAN_SRC_PATH}/clear.sh" "${2}"
        exit 0
    elif [[ "${1}" == "uninstall" || "${1}" == "un" ]]; then
        "${CLIVERMAN_SRC_PATH}/uninstall.sh" "${2}"
        exit 0
    fi
elif [[ "$#" -eq 1 ]]; then
    if [[ "${1}" == "reshim" || "${1}" == "r" ]]; then
        "${CLIVERMAN_SRC_PATH}/reshim.sh"
        exit 0
    elif [[ "${1}" == "update" || "${1}" == "up" ]]; then
        "${CLIVERMAN_SRC_PATH}/update.sh"
        exit 0
    elif [[ "${1}" == "search" || "${1}" == "s" ]]; then
        "${CLIVERMAN_SRC_PATH}/search.sh" "all"
        exit 0
    elif [[ "${1}" == "list" || "${1}" == "l" ]]; then
        "${CLIVERMAN_SRC_PATH}/list.sh" "all"
        exit 0
    fi
fi

cat <<'ASCII_ART'
   _____ _ _                                      
  / ____| (_)                               
 | |    | |___   _____ _ __ _ __ ___   __ _ _ __  
 | |    | | \ \ / / _ \ '__| '_ ` _ \ / _` | '_ \ 
 | |____| | |\ V /  __/ |  | | | | | | (_| | | | |
  \_____|_|_| \_/ \___|_|  |_| |_| |_|\__,_|_| |_| 
ASCII_ART
printf "               Universal runtime manager - ${CLIVERMAN_VERSION}\n"

printf "\n\
 Usage: \n\
 cliverman [command] [arguments]\n\

 Available commands:\n\
      [s]earch [all]        - Show all available runtimes for installation\n\
               [\`name\`]     - Show all available versions for the specified runtime\n\
        [l]ist [all]        - Show all installed runtimes\n\
               [\`name\`]     - Show all versions installed for the specified runtime\n\
     [i]nstall [\`name:ver\`] - Install the runtime at the specified version\n\
         [u]se [\`name:ver\`] - Set the active version of an already installed runtime (global)\n\
       [c]lear [\`name\`]     - Unset the active version of a runtime, reverting to system default\n\
   [un]install [\`name\`]     - Uninstall all installed versions of a runtime\n\
               [\`name:ver\`] - Uninstall a specific version of a runtime\n\
      [r]eshim              - Recreate shims for all installed runtimes\n\
      [up]date              - Update Cliverman to the latest version\n\
\n\
 Example:\n\
   cliverman install nodejs:14.17.0\n\
   cliverman use nodejs:14.17.0\n\
   cliverman search\n\
   cliverman list\n\
   cliverman list nodejs\n\
   cliverman uninstall nodejs:14.17.0\n\
   cliverman remove nodejs:14.17.0\n\
\n\
\033[93m   github.com/marcoaurelima/cliverman✨\n"

