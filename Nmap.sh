#!/data/data/com.termux/files/usr/bin/bash

clear

# ===== COLORS =====
R="\e[31m"; G="\e[32m"; Y="\e[33m"; C="\e[36m"; N="\e[0m"

echo -e "${G}"
echo "██╗    ██╗██╗  ██╗██╗████████╗███████╗"
echo "██║    ██║██║  ██║██║╚══██╔══╝██╔════╝"
echo "██║ █╗ ██║███████║██║   ██║   █████╗  "
echo "██║███╗██║██╔══██║██║   ██║   ██╔══╝  "
echo "╚███╔███╔╝██║  ██║██║   ██║   ███████╗"
echo " ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝"
echo -e "${C}         whitemantester-cmd${N}"
echo "========================================================"

# ===== INPUT =====
read -p "[?] DOMAIN kiriting: " DOMAIN
read -p "[?] IP kiriting: " IP
read -p "[?] PORT MODE (1 FULL / 2 TOP100): " MODE

if [ -z "$DOMAIN" ] || [ -z "$IP" ]; then
  echo "[!] Xatolik!"
  exit 1
fi

# ===== PORT MODE =====
if [ "$MODE" == "1" ]; then
  PORTS="-p-"
  echo "[+] FULL PORT MODE"
else
  PORTS="-F"
  echo "[+] TOP 100 PORT MODE"
fi

echo "[+] Boshlanmoqda..."
sleep 1

run() {
  echo -e "\n${Y}========== [$1] ==========${N}"
  eval "$2"
}

COMMON="-sT -T4 --min-rate 1000 --max-retries 2 --defeat-rst-ratelimit"

# ===== code =====
run "BASIC + VERBOSE" "nmap $COMMON --open --reason -v $DOMAIN"
run "FULL PORT ULTRA" "nmap $COMMON -p- --open $DOMAIN"
run "TOP PORTS FAST" "nmap -sT --top-ports 1000 -T4 --open $DOMAIN"
run "VERSION DEEP" "nmap -sT -sV --version-all --version-intensity 9 $DOMAIN"
run "OS DETECT EXTREME" "nmap -O --osscan-guess --osscan-limit $IP"
run "AGGRESSIVE FULL" "nmap -sT -A --traceroute --reason $DOMAIN"
run "CORE SCRIPTS" "nmap -sT --script 'default,safe,discovery' $DOMAIN"
run "FULL VULNERABILITY" "nmap -sT --script vuln -v $DOMAIN"
run "AUTH + BRUTE" "nmap -sT --script auth,brute --max-retries 1 $DOMAIN"

run "HTTP ULTRA" "nmap -p 80,443,8080 -sT --script http-title,http-headers,http-methods,http-enum,http-server-header,http-cookie-flags,http-userdir-enum,http-auth,http-robots.txt,http-config-backup $DOMAIN"

run "SSL ULTRA" "nmap -p 443 -sT --script ssl-cert,ssl-enum-ciphers,ssl-heartbleed,ssl-dh-params,ssl-known-key $DOMAIN"

run "DNS ULTRA" "nmap -sT --script dns-brute,dns-recursion,dns-service-discovery,dns-cache-snoop $DOMAIN"

run "SMB FTP ULTRA" "nmap -p 21,445 -sT --script ftp-anon,ftp-bounce,ftp-syst,smb-os-discovery,smb-enum-shares,smb-security-mode,smb-vuln* $DOMAIN"

run "NETWORK TRACE DEEP" "nmap -sT --traceroute --packet-trace --reason $DOMAIN"
run "STEALTH TIMING" "nmap -sT --scan-delay 1s --max-rate 2000 --max-retries 1 $DOMAIN"

run "DNS FORCE" "nmap -sT -R --dns-servers 8.8.8.8 $DOMAIN"
run "NO DNS FAST" "nmap -sT -n $DOMAIN"

run "IPv6 SCAN" "nmap -6 -sT $DOMAIN"

run "IP FAST" "nmap -F $IP"
run "IP FULL" "nmap -sT -p- -T4 $IP"

run "HYBRID SCAN" "nmap -sT -p 80,443,21,22,25,53,445,3306 $DOMAIN $IP"

run "FINAL GOD MODE" "nmap -sT -p- -sV -O -T4 --min-rate 1500 --script 'default,vuln,auth,brute,discovery,safe' $DOMAIN"

# ===== commands =====
run "BASIC SCAN" "nmap $DOMAIN"
run "TCP CONNECT" "nmap -sT $DOMAIN"
run "PORT 80" "nmap -p 80 $DOMAIN"
run "PORT RANGE" "nmap -p 1-1000 $DOMAIN"
run "FULL PORT" "nmap -p- $DOMAIN"
run "FAST SCAN" "nmap -F $DOMAIN"

run "SERVICE VERSION" "nmap -sV $DOMAIN"
run "SERVICE 80/443" "nmap -sV -p 80,443 $DOMAIN"

run "AGGRESSIVE" "nmap -A $DOMAIN"

run "TIMING T0" "nmap -T0 $DOMAIN"
run "TIMING T1" "nmap -T1 $DOMAIN"
run "TIMING T2" "nmap -T2 $DOMAIN"
run "TIMING T3" "nmap -T3 $DOMAIN"
run "TIMING T4" "nmap -T4 $DOMAIN"
run "TIMING T5" "nmap -T5 $DOMAIN"

run "PING SCAN" "nmap -sn $DOMAIN"
run "LAN SCAN" "nmap -sn 192.168.1.0/24"

run "MULTI TARGET" "nmap 192.168.1.1 192.168.1.2"
run "RANGE SCAN" "nmap 192.168.1.1-50"
run "SUBNET SCAN" "nmap 192.168.1.0/24"

run "OUTPUT NORMAL" "nmap -oN result.txt $DOMAIN"
run "OUTPUT XML" "nmap -oX result.xml $DOMAIN"
run "OUTPUT GREP" "nmap -oG result.gnmap $DOMAIN"
run "OUTPUT ALL" "nmap -oA allresult $DOMAIN"

run "DEFAULT SCRIPT" "nmap --script=default $DOMAIN"
run "SAFE SCRIPT" "nmap --script=safe $DOMAIN"
run "HTTP SCRIPT" "nmap --script=http* $DOMAIN"
run "SSL SCRIPT" "nmap --script=ssl* $DOMAIN"
run "FTP SCRIPT" "nmap --script=ftp* $DOMAIN"
run "SMB SCRIPT" "nmap --script=smb* $DOMAIN"

run "HTTP TITLE" "nmap --script=http-title $DOMAIN"
run "HTTP HEADERS" "nmap --script=http-headers $DOMAIN"
run "HTTP METHODS" "nmap --script=http-methods $DOMAIN"
run "HTTP ENUM" "nmap --script=http-enum $DOMAIN"

run "FTP BRUTE" "nmap --script=ftp-brute $DOMAIN"
run "SSH BRUTE" "nmap --script=ssh-brute $DOMAIN"

run "SSL CERT" "nmap --script=ssl-cert $DOMAIN"
run "SSL CIPHERS" "nmap --script=ssl-enum-ciphers $DOMAIN"

run "FIREWALL BYPASS" "nmap -Pn $DOMAIN"
run "DATA LENGTH" "nmap --data-length 50 $DOMAIN"

run "OS DETECT" "nmap -O $DOMAIN"
run "VERBOSE" "nmap -v $DOMAIN"
run "VERY VERBOSE" "nmap -vv $DOMAIN"

run "DNS LIST" "nmap -sL $DOMAIN"
run "DNS CUSTOM" "nmap --dns-servers 8.8.8.8 $DOMAIN"

run "COMBO FAST" "nmap -sT -sV -T4 $PORTS $DOMAIN"
run "COMBO AGGR" "nmap -sT -A -Pn $DOMAIN"
run "COMBO VULN" "nmap -sT --script=vuln -T4 $DOMAIN"

# ===== AUTO OPEN PORT =====
echo -e "${C}[+] Open port aniqlanmoqda...${N}"
open_ports=$(nmap $PORTS --open $DOMAIN | grep "^[0-9]" | cut -d "/" -f1 | tr '\n' ',' | sed 's/,$//')

echo -e "${G}[✔] Open Ports: $open_ports${N}"

if [ ! -z "$open_ports" ]; then
  run "DEEP OPEN PORT SCAN" "nmap -sT -sV -p $open_ports --script=vuln $DOMAIN"
fi

echo ""
echo "========================================================"
echo "[✓]  nmap termux no root!"
echo "========================================================"
