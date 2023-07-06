#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Checking VPS"
#########################

# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
GREEEN='\e[1;32m'
blue='\e[34m'
PURPLE='\e[35m'
CY='\e[1;36m'
Lred='\e[91m'
Lgreen='\e[92m'
YELLOW='\e[93m'
LWHITE='\e[97m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
# VPS Information
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
clear                                                                                        
echo -e "\e[33m Operating System     \e[0m┣❏  "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`	
echo -e "\e[33m Total Amount Of RAM  \e[0m┣❏  $tram MB"
echo -e "\e[33m System Uptime        \e[0m┣❏  $uptime "
echo -e "\e[33m Isp Name             \e[0m┣❏  $ISP"
echo -e "\e[33m Domain               \e[0m┣❏  $domain"	
echo -e "\e[33m Ip Vps               \e[0m┣❏  $IPVPS"
echo -e ""	
echo -e "${GREEEN}╭━━━━━「Account Menu 」                ${NC}            "
echo -e "${YELLOW}│                                    ${NC}            " 
echo -e "${YELLOW}│❏>${NC} 1 ${CY}Ssh / OvPn           ${NC}            "
echo -e "${YELLOW}│❏>${NC} 2 ${CY}Vmess Menu           ${NC}            "
echo -e "${YELLOW}│❏>${NC} 3 ${CY}Vless Menu           ${NC}            "
echo -e "${YELLOW}│❏>${NC} 4 ${CY}Trojan Go Menu       ${NC}            "                  
echo -e "${YELLOW}│❏>${NC} 5 ${CY}Trojan GPW           ${NC}            "
echo -e ""
echo -e "${GREEEN}╭━━━━━「System Menu 」 ${NC}"
echo -e "${YELLOW}│"${NC}"
echo -e "${YELLOW}│❏>${NC} 6 ${NC} ${CY}Extra  Menu"
echo -e "${YELLOW}│❏>${NC} 7 ${NC} ${CY}Status Service"
echo -e "${YELLOW}│❏>${NC} 8 ${NC} ${CY}Clear Cache"
echo -e "${YELLOW}│❏>${NC} 9 ${NC} ${CY}Update Menu"
echo -e "${YELLOW}│❏>${NC} x ${NC} ${CY}Exit"
echo -e "${LWHITE}"
read -p " 「Selected Menu 」  >>   "  opt
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trgo ;;
5) clear ; menu-trojan ;;
6) clear ; menu-set ;;
7) clear ; running ;;
8) clear ; clearcache ;;
9) clear ; updatemenu ;;
x) exit ;;
esac
