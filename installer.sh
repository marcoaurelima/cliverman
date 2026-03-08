#!/usr/bin/env bash
# set -euo pipefail
# IFS=$'\n\t'

cat <<'ASCII_ART'
   _____ _ _                                      
  / ____| (_)                                 
 | |    | |___   _____ _ __ _ __ ___   __ _ _ __  
 | |    | | \ \ / / _ \ '__| '_ ` _ \ / _` | '_ \ 
 | |____| | |\ V /  __/ |  | | | | | | (_| | | | |
  \_____|_|_| \_/ \___|_|  |_| |_| |_|\__,_|_| |_|  
               Universal runtime manager  

ASCII_ART

echo "Installing Cliverman..."
git clone https://github.com/marcoaurelima/cliverman.git "${HOME}/.cliverman2" >> /dev/null 2>&1
result=$?
if [[ $result -ne 0 ]]; then
    echo -e "\033[0;91mError: Failed to clone Cliverman repository. Please check your internet connection and try again.\033[0m"
    exit 1
fi
echo -e "\033[0;92mCliverman installed successfully at ${HOME}/.cliverman\033[0m\n"

echo "Please add the following line to your shell configuration file (e.g., .bashrc, .zshrc):"
echo -e "\033[0;93mexport PATH=\"${HOME}/.cliverman/bin:${PATH}\"\033[0m"
echo "Then, restart your terminal or run 'source ~/.bashrc' (or 'source ~/.zshrc') to start using Cliverman."       

