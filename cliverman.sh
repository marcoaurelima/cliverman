#!/bin/bash

if [[ "$#" -eq 2 ]]; then
    if [[ "$1" == "list" ]]; then
        ./src/list.sh "$2"
        exit 0
    elif [[ "$1" == "install" ]]; then 
        ./src/install.sh "$2"
        exit 0
    elif [[ "$1" == "use" ]]; then 
        ./src/use.sh "$2"
        exit 0
    elif [[ "$1" == "search" ]]; then
        ./src/search.sh "$2"
        exit 0
    fi
    exit 0
fi

cat <<'ASCII_ART'
   _____ _ _                                      
  / ____| (_)                                     
 | |    | |___   _____ _ __ _ __ ___   __ _ _ __  
 | |    | | \ \ / / _ \ '__| '_ ` _ \ / _` | '_ \ 
 | |____| | |\ V /  __/ |  | | | | | | (_| | | | |
  \_____|_|_| \_/ \___|_|  |_| |_| |_|\__,_|_| |_|                                                                                   
ASCII_ART

echo "Como usar:"
echo "  cliverman [comando] [argumentos]"
echo ""
echo "Comandos disponíveis:"
echo "     search [all]          - Exibe todos os runtimes disponiveis para instalação"
echo "            [\`name\`]     - Exibe todas as versões disponíveis do runtime especificado" 
echo "       list [all]          - Exibe todos os runtimes instaladas" 
echo "            [\`name\`]     - Exibe todas as versões já instaladas deste runtime" 
echo "    install [\`name:ver\`] - Instala o runtime na versão especificada" 
echo "        use [\`name:ver\`] - Define a versão ativa de um runtime já instalada (globalmente)" 
echo "  uninstall [\`name:ver\`] - Desinstala uma versão específica de um runtime" 
echo "     remove [\`name:ver\`] - Remove binários/configurações de uma versão específica de um runtime" 
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

