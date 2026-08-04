#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

cat <<'ASCII_ART'
   _____ _ _                                      
  / ____| (_)                                 
 | |    | |___   _____ _ __ _ __ ___   __ _ _ __  
 | |    | | \ \ / / _ \ '__| '_ ` _ \ / _` | '_ \ 
 | |____| | |\ V /  __/ |  | | | | | | (_| | | | |
  \_____|_|_| \_/ \___|_|  |_| |_| |_|\__,_|_| |_|  

ASCII_ART

echo -n "  Installing... "
git clone https://github.com/marcoaurelima/cliverman.git "${HOME}/.cliverman" >> /dev/null 2>&1
result=$?
if [[ $result -ne 0 ]]; then
    echo -e "\033[0;91mError: Failed to clone Cliverman repository. Please check your internet connection and try again.\033[0m"
    exit 1
fi

# Switch to last version tag
pushd "${HOME}/.cliverman" || exit 1
git checkout "$(git describe --tags --abbrev=0)" >> /dev/null 2>&1
result=$?
if [[ $result -ne 0 ]]; then
    echo -e "\033[0;91mError: Failed to checkout the latest version tag. Please check your internet connection and try again.\033[0m"
    exit 1
fi
popd

echo -e "\033[0;92mSUCCESS\033[0m\n"

echo "  Instructions:"
echo "  1. Add the following line to your shell configuration (e.g., .bashrc, .zshrc):"
echo -e "\033[0;96m     export PATH=\"\${HOME}/.cliverman/shims:\${PATH}\"\033[0m"
echo "  2. Restart your terminal."       

