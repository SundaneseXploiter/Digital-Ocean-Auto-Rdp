RED='\033[0;31m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'  
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' 

apt update
clear

echo -e "${MAGENTA}"
echo " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo " ┃                             ${YELLOW}WARKOP DIGITAL INSTALLER${MAGENTA}                             ┃"
echo " ┃                                 ${WHITE}Premium RDP Builder${MAGENTA}                                 ┃"
echo " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "${NC}"

echo -e "${WHITE}                               © susudosu — All rights reserved${NC}"
echo ""

echo -e "${MAGENTA} ┌────────────────────────────────────────────────────────────────────────────────────────┐ ${NC}"
echo -e "${MAGENTA} │${NC} ${RED}NOTE:${NC} ${YELLOW}Pastikan VPS Anda menggunakan Debian 12 / Ubuntu 22${NC}                     ${MAGENTA}│ ${NC}"
echo -e "${MAGENTA} │${NC} ${YELLOW}Jika provider tidak tersedia, hubungi owner untuk tester VPS Anda.${NC}          ${MAGENTA}│ ${NC}"
echo -e "${MAGENTA} ├────────────────────────────────────────────────────────────────────────────────────────┤ ${NC}"
echo -e "${MAGENTA} │${NC} ${RED}Script akan gagal jika provider yang dipilih tidak sesuai.${NC}                ${MAGENTA}│ ${NC}"
echo -e "${MAGENTA} └────────────────────────────────────────────────────────────────────────────────────────┘ ${NC}"

echo ""
echo -e "${MAGENTA} ┌────────────────────────────────────────────────────────────────────────────────────────┐ ${NC}"
echo -e "${MAGENTA} │${NC}                 ${CYAN}Silakan pilih provider VPS untuk instalasi RDP:${NC}                    ${MAGENTA}│ ${NC}"
echo -e "${MAGENTA} ├────────────────────────────────────────────────────────────────────────────────────────┤ ${NC}"
echo -e "${MAGENTA} │${NC} ${CYAN} 1) DigitalOcean${NC}                                                         ${MAGENTA}│ ${NC}"
echo -e "${MAGENTA} │${NC} ${CYAN} 2) Coming Soon${NC}                                                          ${MAGENTA}│ ${NC}"
echo -e "${MAGENTA} └────────────────────────────────────────────────────────────────────────────────────────┘ ${NC}"

read -p "Masukkan pilihan Anda (1-2): " pilihan
echo -e "${MAGENTA} ┌────────────────────────────────────────────────────────────────────────────────────────┐ ${NC}"

case $pilihan in
    1)
        echo -e "${MAGENTA} │${NC} ${CYAN}Memulai instalasi RDP untuk DigitalOcean...${NC} ${MAGENTA}│ ${NC}"
        wget -q https://raw.githubusercontent.com/SundaneseXploiter/DO-AUTO-SETUP-RDP/refs/heads/main/do.sh && bash do.sh
        ;;
    *)
        echo -e "${MAGENTA} │${NC} ${RED}Pilihan tidak valid. Harap pilih angka 1.${NC} ${MAGENTA}│ ${NC}"
        echo -e "${MAGENTA} └────────────────────────────────────────────────────────────────────────────────────────┘ ${NC}"
        exit 1
        ;;
esac

echo -e "${MAGENTA} └────────────────────────────────────────────────────────────────────────────────────────┘ ${NC}"
