#!/usr/bin/env bash
# set -euo pipefail
# IFS=$'\n\t'

readonly CLIVERMAN_VERSION="1.0.0"

# Load Cliverman environment variables
# shellcheck disable=SC1091
# source "${HOME}/.cliverman/config/config.sh"

# Ensure `config.sh` runs whenever cliverman is invoked
"${HOME}/.cliverman/config/config.sh"

if [[ "$#" -eq 2 ]]; then
    if [[ "${1}" == "list" ]]; then
        "${CLIVERMAN_SRC_PATH}/list.sh" "${2}"
        exit 0
    elif [[ "${1}" == "install" ]]; then 
        "${CLIVERMAN_SRC_PATH}/install.sh" "${2}"
        exit 0
    elif [[ "${1}" == "use" ]]; then 
        "${CLIVERMAN_SRC_PATH}/use.sh" "${2}"
        exit 0
    elif [[ "${1}" == "search" ]]; then
        "${CLIVERMAN_SRC_PATH}/search.sh" "${2}"
        exit 0
    elif [[ "${1}" == "clear" ]]; then
        "${CLIVERMAN_SRC_PATH}/clear.sh" "${2}"
        exit 0
    elif [[ "${1}" == "uninstall" ]]; then
        "${CLIVERMAN_SRC_PATH}/uninstall.sh" "${2}"
        exit 0
    fi
elif [[ "$#" -eq 1 ]]; then
    if [[ "${1}" == "reshim" ]]; then
        "${CLIVERMAN_SRC_PATH}/reshim.sh"
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
echo "     search [all]        - Show all available runtimes for installation"
echo "            [\`name\`]     - Show all available versions for the specified runtime" 
echo "       list [all]        - Show all installed runtimes" 
echo "            [\`name\`]     - Show all versions installed for the specified runtime" 
echo "    install [\`name:ver\`] - Install the runtime at the specified version" 
echo "        use [\`name:ver\`] - Set the active version of an already installed runtime (global)" 
echo "      clear [\`name\`]     - Unset the active version of a runtime, reverting to system default" 
echo "  uninstall [\`name\`]     - Uninstall all installed versions of a runtime" 
echo "            [\`name:ver\`] - Uninstall a specific version of a runtime" 
echo "     reshim              - Recreate shims for all installed runtimes" 
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

