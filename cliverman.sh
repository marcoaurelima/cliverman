#!/usr/bin/env bash
# set -euo pipefail
# IFS=$'\n\t'

readonly CLIVERMAN_VERSION="0.1.1"

# Load Cliverman environment variables
# shellcheck disable=SC1091
source "${HOME}/.cliverman/config/env.sh"

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
               Universal runtime manager   
ASCII_ART
echo "               v${CLIVERMAN_VERSION}"

echo "Usage:"
echo "  cliverman [command] [arguments]"
echo ""
echo "Available commands:"
echo "     [s]earch [all]        - Show all available runtimes for installation"
echo "              [\`name\`]     - Show all available versions for the specified runtime" 
echo "       [l]ist [all]        - Show all installed runtimes" 
echo "              [\`name\`]     - Show all versions installed for the specified runtime" 
echo "    [i]nstall [\`name:ver\`] - Install the runtime at the specified version" 
echo "        [u]se [\`name:ver\`] - Set the active version of an already installed runtime (global)" 
echo "      [c]lear [\`name\`]     - Unset the active version of a runtime, reverting to system default" 
echo "  [un]install [\`name\`]     - Uninstall all installed versions of a runtime" 
echo "              [\`name:ver\`] - Uninstall a specific version of a runtime" 
echo "     [r]eshim              - Recreate shims for all installed runtimes" 
echo "     [up]date              - Update Cliverman to the latest version" 
echo ""
echo "Example:"
echo "  cliverman install nodejs:14.17.0"
echo "  cliverman use nodejs:14.17.0"
echo "  cliverman search"
echo "  cliverman list"
echo "  cliverman list nodejs"
echo "  cliverman uninstall nodejs:14.17.0"
echo "  cliverman remove nodejs:14.17.0"
echo ""
echo -e "\033[93m github.com/marcoaurelima/✨cliverman✨"

