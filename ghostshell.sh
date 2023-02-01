#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

hostname=$(hostname)

echo -e "\n"
toilet -f smbraille 'GhostShell'
echo -e "\n"
echo -e "${YELLOW}[+] Starting Shell...${ENDCOLOR}\n"

systemctl status tor.service | grep " active" >/dev/null
e=$(echo $?)

if [ $e == 0 ]; then
	echo -e "${GREEN}[+] Tor Active${ENDCOLOR}\n"
else
	echo -e "${RED}[-] Tor Inactive${ENDCOLOR}\n"
        exit
fi

echo -e "${YELLOW}[*] IP Address: $(proxychains4 -q curl -s https://api.ipify.org/)"

while [ "$command" != "exit" ]
do
	echo -e "${BLUE}"
	read -p "ghost@$hostname~# " command 
	echo -e "${ENDCOLOR}"
	proxychains4 -q $command 
done
