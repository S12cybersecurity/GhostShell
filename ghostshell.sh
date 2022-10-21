#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

hostname=$(hostname)

echo -e "\n"
toilet -f smbraille --gay 'GhostShell'
echo -e "\n"
echo -e "${YELLOW}[+] Starting Shell...${ENDCOLOR}\n"

service tor status | grep " active" >/dev/null
e=$(echo $?)

if [ $e == 0 ]; then
	echo -e "${GREEN}[+] Tor Active${ENDCOLOR}"
else
	echo -e "${RED}[-] Tor Inactive${ENDCOLOR}\n"
        exit
fi


while [ "$command" != "exit" ]
do
	echo -e "${BLUE}"
	read -p "ghost@$hostname~# " command 
	echo -e "${ENDCOLOR}"
	proxychains4 -q $command 
done

