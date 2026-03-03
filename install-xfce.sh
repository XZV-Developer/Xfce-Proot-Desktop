#!/data/data/com.termux/files/usr/bin/bash

# Warna Terminal
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
NC='\033[0m'

# ==============================
# ASCII ART
# ==============================

echo -e "${CYAN}${BOLD}"
echo " ___ _   _ ____ _____  _    _     _     _____ ____  "
echo "|_ _| \ | / ___|_   _|/ \  | |   | |   | ____|  _ \ "
echo " | ||  \| \___ \ | | / _ \ | |   | |   |  _| | |_) |"
echo " | || |\  |___) || |/ ___ \| |___| |___| |___|  _ < "
echo "|___|_| \_|____/ |_/_/   \_\_____|_____|_____|_| \_\\"
echo ""
echo -e "${NC}"

# ==============================
# PILIH BAHASA
# ==============================

echo -e "${CYAN}====================================${NC}"
echo -e "${CYAN}  Select Language / Pilih Bahasa    ${NC}"
echo -e "${CYAN}====================================${NC}"
echo "1. English"
echo "2. Bahasa Indonesia"
echo ""
read -p "Choose / Pilih (1/2): " LANG_CHOICE

if [ "$LANG_CHOICE" = "2" ]; then
    INSTALL_MSG="Memulai Instalasi Debian XFCE untuk Termux:X11..."
    INSTALL_DEBIAN="Menginstal Debian..."
    CONFIG_MSG="Mengonfigurasi User & Aplikasi Debian..."
    COMPLETE_MSG="INSTALASI SELESAI!"
    HOW_TO="Cara Pakai:"
    ERR_FILE="File tidak ditemukan"
else
    INSTALL_MSG="Starting Debian XFCE Installation for Termux:X11..."
    INSTALL_DEBIAN="Installing Debian..."
    CONFIG_MSG="Configuring Debian User & Apps..."
    COMPLETE_MSG="INSTALLATION COMPLETE!"
    HOW_TO="How To Use:"
    ERR_FILE="File not found"
fi

echo -e "${CYAN}$INSTALL_MSG${NC}"

# ==============================
# 1. Update & Install Termux Packages
# ==============================
pkg update && pkg upgrade -y
pkg install proot-distro pulseaudio termux-x11-nightly -y

# ==============================
# 2. Install Debian
# ==============================
echo -e "${GREEN}$INSTALL_DEBIAN${NC}"
proot-distro install debian

# ==============================
# 3. Setup Alias Global (dengan pengecekan file)
# ==============================
for f in starts.sh stopd.sh; do
    if [ ! -f "$f" ]; then
        echo -e "${RED}[ERROR] $ERR_FILE: $f${NC}"
        exit 1
    fi
done

cp starts.sh "$PREFIX/bin/starts"
cp stopd.sh "$PREFIX/bin/stopd"
chmod +x "$PREFIX/bin/starts" "$PREFIX/bin/stopd"

# ==============================
# 4. Konfigurasi Debian
# ==============================
USERNAME="Home"
echo -e "${GREEN}$CONFIG_MSG${NC}"

# Export supaya bisa dipakai di subshell proot
export USERNAME

proot-distro login debian -- bash -c "
set -e
apt update && apt upgrade -y
apt install -y xfce4 xfce4-goodies dbus-x11 sudo
apt install -y firefox-esr mpv mousepad pulseaudio

# Buat user hanya jika belum ada
if ! id -u '$USERNAME' >/dev/null 2>&1; then
    useradd -m -s /bin/bash '$USERNAME'
fi

echo '$USERNAME:1234' | chpasswd
usermod -aG sudo '$USERNAME'

# Setup Desktop shortcuts
sudo -u '$USERNAME' bash -c '
mkdir -p ~/Desktop
for desk in firefox-esr.desktop mpv.desktop org.xfce.mousepad.desktop; do
    [ -f \"/usr/share/applications/\$desk\" ] && cp \"/usr/share/applications/\$desk\" ~/Desktop/
done
chmod +x ~/Desktop/*.desktop
'
"

# ==============================
# 5. Setup startd di Debian user
# ==============================
if [ ! -f "startd.sh" ]; then
    echo -e "${RED}[ERROR] $ERR_FILE: startd.sh${NC}"
    exit 1
fi

DEBIAN_USER_BIN="$PREFIX/var/lib/proot-distro/installed-rootfs/debian/home/$USERNAME/.local/bin"
mkdir -p "$DEBIAN_USER_BIN"
cp startd.sh "$DEBIAN_USER_BIN/startd"
chmod +x "$DEBIAN_USER_BIN/startd"

# Tambahkan PATH hanya jika belum ada (hindari duplikat)
proot-distro login debian --user "$USERNAME" -- bash -c "
grep -qxF 'export PATH=\$PATH:~/.local/bin' ~/.bashrc || echo 'export PATH=\$PATH:~/.local/bin' >> ~/.bashrc
"

# ==============================
# FINISH MESSAGE
# ==============================

echo ""
echo -e "${CYAN}==============================================${NC}"
echo -e "${GREEN}${BOLD}  $COMPLETE_MSG${NC}"
echo -e "${CYAN}==============================================${NC}"
echo -e "${YELLOW}$HOW_TO${NC}"
echo -e "  1. ${CYAN}starts${NC}"
echo -e "  2. Open ${BOLD}Termux:X11${NC} app"
echo -e "  3. ${CYAN}proot-distro login debian --user $USERNAME${NC}"
echo -e "  4. ${CYAN}startd${NC}  ${YELLOW}<-- jalankan XFCE${NC}"
echo -e "  5. ${CYAN}stopd${NC}   ${YELLOW}<-- stop session${NC}"
echo -e "${CYAN}==============================================${NC}"
