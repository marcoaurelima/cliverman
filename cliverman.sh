#!/usr/bin/env bash
set -e

readonly CLIVERMAN_VERSION="1.0.0"

# Carregar variáveis de ambiente do Cliverman
# shellcheck disable=SC1091
source "${HOME}/.cliverman/config/config.sh"

if [[ "$#" -eq 2 ]]; then
    if [[ "$1" == "list" ]]; then
        "${CLIVERMAN_SRC_PATH}/list.sh" "$2"
        exit 0
    elif [[ "$1" == "install" ]]; then 
        "${CLIVERMAN_SRC_PATH}/install.sh" "$2"
        exit 0
    elif [[ "$1" == "use" ]]; then 
        "${CLIVERMAN_SRC_PATH}/use.sh" "$2"
        exit 0
    elif [[ "$1" == "search" ]]; then
        "${CLIVERMAN_SRC_PATH}/search.sh" "$2"
        exit 0
    elif [[ "$1" == "uninstall" ]]; then
        "${CLIVERMAN_SRC_PATH}/uninstall.sh" "$2"
        exit 0
    fi
elif [[ "$#" -eq 1 ]]; then
    if [[ "$1" == "reshim" ]]; then
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
               Gerenciador de runtimes universal   
ASCII_ART
echo "               v${CLIVERMAN_VERSION}"

echo "Como usar:"
echo "  cliverman [comando] [argumentos]"
echo ""
echo "Comandos disponíveis:"
echo "     search [all]        - Exibe todos os runtimes disponiveis para instalação"
echo "            [\`name\`]     - Exibe todas as versões disponíveis do runtime especificado" 
echo "       list [all]        - Exibe todos os runtimes instaladas" 
echo "            [\`name\`]     - Exibe todas as versões já instaladas deste runtime" 
echo "    install [\`name:ver\`] - Instala o runtime na versão especificada" 
echo "        use [\`name:ver\`] - Define a versão ativa de um runtime já instalada (globalmente)" 
echo "  uninstall [\`name\`]     - Desinstala todas as versões instaladas de um runtime" 
echo "            [\`name:ver\`] - Desinstala uma versão específica de um runtime" 
echo "     reshim                - Recria os shims para todos os runtimes instalados" 
echo ""
echo "Exemplo:"
echo "  cliverman install nodejs:14.17.0"
echo "  cliverman use nodejs:14.17.0"
echo "  cliverman search"
echo "  cliverman list"
echo "  cliverman list nodejs"
echo "  cliverman uninstall nodejs:14.17.0"
echo "  cliverman remove nodejs:14.17.0"
echo ""
echo -e "\033[93m github.com/marcoaurelima/✨cliverman✨"

