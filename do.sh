#!/bin/bash

clear

# ==============================================
# COLORS
# ==============================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BLUE='\033[1;34m'
WHITE='\033[1;37m'
NC='\033[0m'

# ==============================================
# CONFIGURATIONS 
# ==============================================
SECRET_KEY="su"
EXPIRY_DATE="2099-03-31"

current_date=$(date +%Y-%m-%d)

if [[ "$current_date" > "$EXPIRY_DATE" ]]; then
    echo -e "${RED}The script has expired. Please contact the administrator.${NC}"
    exit 1
fi

expiry_seconds=$(date -d "$EXPIRY_DATE" +%s)
current_seconds=$(date +%s)
remaining_seconds=$((expiry_seconds - current_seconds))
remaining_days=$((remaining_seconds / 86400))

# ==============================================
# HEADER UI 
# ==============================================
echo -e "${CYAN}"
echo " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo " ┃                     WINDOWS AUTO INSTALLER v1.0                     ┃"
echo " ┃                         Warkop Digital System                       ┃"
echo " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "${NC}"
echo -e "${YELLOW}                          © susudosu ${NC}"
echo ""

# ==============================================
# SECRET KEY 
# ==============================================
echo -e "${MAGENTA} ┌──────────────────────────────────────────────────────────────────────┐ ${NC}"
echo -e "${MAGENTA} │${CYAN}              Please enter your secret key to unlock the script${MAGENTA}             │ ${NC}"
echo -e "${MAGENTA} └──────────────────────────────────────────────────────────────────────┘ ${NC}"

read -sp "Enter the key: " input_key
echo

if [ "$input_key" != "$SECRET_KEY" ]; then
    echo -e "${RED}Invalid key. Access denied.${NC}"
    exit 1
fi

# ==============================================
# SERVER INFO 
# ==============================================
echo -e "${BLUE} ┌──────────────────────────────────────────────────────────────────────┐ ${NC}"
echo -e "${BLUE} │${WHITE}                        SERVER INFORMATION                         ${BLUE}│${NC}"
echo -e "${BLUE} ├──────────────────────────────────────────────────────────────────────┤ ${NC}"
echo -e "${BLUE} │${NC} ${CYAN}Version       : 1.0 WD${NC}"
echo -e "${BLUE} │${NC} ${CYAN}Creator       : Warkop Digital${NC}"
echo -e "${BLUE} │${NC} ${CYAN}Client Name   : Windows RDP${NC}"
echo -e "${BLUE} │${NC} ${CYAN}Provider      : DigitalOcean${NC}"
echo -e "${BLUE} │${NC} ${CYAN}Expiry In     : ${remaining_days} days remaining${NC}"
echo -e "${BLUE} └──────────────────────────────────────────────────────────────────────┘ ${NC}"
echo ""

# ==============================================
# WINDOWS MENU 
# ==============================================
echo -e "${MAGENTA} ┌──────────────────────────────────────────────┐ ${NC}"
echo -e "${MAGENTA} │${WHITE}           Select Your Windows Version          ${MAGENTA}│ ${NC}"
echo -e "${MAGENTA} ├──────────────────────────────────────────────┤ ${NC}"
echo -e "${MAGENTA} │${CYAN} 1) Windows Server 2012${MAGENTA}                       │${NC}"
echo -e "${MAGENTA} │${CYAN} 2) Windows Server 2016${MAGENTA}                       │${NC}"
echo -e "${MAGENTA} │${CYAN} 3) Windows Server 2019${MAGENTA}                       │${NC}"
echo -e "${MAGENTA} │${CYAN} 4) Windows Server 2022${MAGENTA}                       │${NC}"
echo -e "${MAGENTA} │${CYAN} 5) Windows Server 10  ${MAGENTA}                       │${NC}"
echo -e "${MAGENTA} │${CYAN} 6) Windows Server 11  ${MAGENTA}                       │${NC}"
echo -e "${MAGENTA} └──────────────────────────────────────────────┘ ${NC}"

read -p "Pilih (1-6): " pilihan

case $pilihan in
    1) PILIHOS="https://sourceforge.net/projects/nixpoin/files/windows2012.gz" ;;
    2) PILIHOS="https://sourceforge.net/projects/nixpoin/files/windows2016.gz" ;;
    3) PILIHOS="https://sourceforge.net/projects/nixpoin/files/windows2019.gz" ;;
    4) PILIHOS="https://sourceforge.net/projects/nixpoin/files/windows2022.gz" ;;
    5) PILIHOS="https://sourceforge.net/projects/nixpoin/files/windows10.gz" ;;
    6) PILIHOS="https://sourceforge.net/projects/nixpoin/files/windows11.gz" ;;
    *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
esac

# ==============================================
# PASSWORD MENU 
# ==============================================
echo -e "${CYAN}Apakah Anda ingin mengatur kata sandi untuk akun Administrator?${NC}"
echo -e "${CYAN}1) Ya${NC}"
echo -e "${CYAN}2) Tidak, gunakan default${NC}"
read -p "Pilih (1-2): " set_password

if [ "$set_password" -eq 1 ]; then
    read -sp "Masukkan kata sandi: " PASSWORD
    echo
else
    PASSWORD="JoestarMo35623#"
    echo -e "${GREEN}Using default password: $PASSWORD${NC}"
fi

# ==============================================
# SISA SCRIPT
# ==============================================
IP4=$(curl -4 -s icanhazip.com)
GW=$(ip route | awk '/default/ { print $3 }')

cat >/tmp/net.bat<<EOF
@ECHO OFF
cd.>%windir%\GetAdmin
if exist %windir%\GetAdmin (del /f /q "%windir%\GetAdmin") else (
echo CreateObject^("Shell.Application"^).ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\Admin.vbs"
"%temp%\Admin.vbs"
del /f /q "%temp%\Admin.vbs"
exit /b 2)
net user Administrator $PASSWORD

netsh -c interface ip set address name="Ethernet" source=static address=$IP4 mask=255.255.240.0 gateway=$GW
netsh -c interface ip add dnsservers name="Ethernet" address=1.1.1.1 index=1 validate=no
netsh -c interface ip add dnsservers name="Ethernet" address=8.8.4.4 index=2 validate=no

cd /d "%ProgramData%/Microsoft/Windows/Start Menu/Programs/Startup"
del /f /q net.bat
exit
EOF

echo "Mendownload file $PILIHOS..."
wget --no-check-certificate -O- $PILIHOS | gunzip | dd of=/dev/vda bs=3M status=progress

mount.ntfs-3g /dev/vda2 /mnt
cd "/mnt/ProgramData/Microsoft/Windows/Start Menu/Programs/"
cd Start* || cd start*; \
wget https://nixpoin.com/ChromeSetup.exe
cp -f /tmp/net.bat net.bat

echo -e "${RED}Your server will turn off in 3 seconds...${NC}"
sleep 3
poweroff
