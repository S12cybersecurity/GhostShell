#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "\n"
toilet -f smbraille --gay 'GhostShell'
echo -e "\n"
echo -e "${YELLOW}[+] Searching Dependencies${ENDCOLOR}\n"

which tor >/dev/null
a=$(echo $?)

which proxychains >/dev/null
b=$(echo $?)

which toilet >/dev/null
c=$(echo $?)

hostname=$(hostname)

if [ $a == 0 ]; then
        echo -e "${GREEN}[+] Tor Found${ENDCOLOR}"
        if [ $b == 0 ]; then
                echo -e "${GREEN}[+] ProxyChains Found${ENDCOLOR}"
		if [ $c == 0 ]; then
                	echo -e "${GREEN}[+] Toilet Found${ENDCOLOR}"
		else
			echo -e "${RED}[-] Missing Toilet${ENDCOLOR}\n"
                	exit
        	fi
	else
                echo -e "${RED}[-] Missing ProxyChains${ENDCOLOR}\n"
		exit
        fi
else
	echo -e "${RED}[-] Missing Tor${ENDCOLOR}\n"
	exit
fi



rm /etc/proxychains.conf 2>/dev/null

wget https://raw.githubusercontent.com/S12cybersecurity/GhostShell/main/proxychains.conf -q | mv proxychains.conf /etc/. >/dev/null

service tor start



while [ "$command" != "exit" ]
do
	echo -e "${BLUE}"
	read -p "ghost@$hostname~# " command 
	echo -e "${ENDCOLOR}"
	proxychains -q $command
done
