#!/bin/bash

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
echo "    install [\`tool_name:version\`] - Exibe todas as versões instaladas desta ferramenta" 
echo "        use [\`tool_name:version\`] - Define a versão ativa de uma ferramenta instalada (globalmente)" 
echo "       list [all]                 - Exibe todos as ferramentas disponíveis para instalação" 
echo "            [local]               - Exibe todos as ferramentas instaladas" 
echo "            [\`tool_name\`]         - Exibe todas as versões instaladas desta ferramenta" 
echo "  uninstall [\`tool_name:version\`] - Desinstala uma versão específica de uma ferramenta" 
echo "     remove [\`tool_name:version\`] - Remove binários/configurações de uma versão específica de uma ferramenta" 
echo ""
echo "Exemplo:"
echo "  cliverman install node:14.17.0"
echo "  cliverman use node:14.17.0"
echo "  cliverman list all"
echo "  cliverman list local"
echo "  cliverman uninstall node:14.17.0"
echo "  cliverman remove node:14.17.0"
echo ""
