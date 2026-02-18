#!/data/data/com.termux/files/usr/bin/bash

# Warna Terminal
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# ==============================
# PILIH BAHASA
# ==============================

echo -e "${CYAN}====================================${NC}"
echo -e "${CYAN} Select Language / Pilih Bahasa ${NC}"
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
else
    INSTALL_MSG="Starting Debian XFCE Installation for Termux:X11..."
    INSTALL_DEBIAN="Installing Debian..."
    CONFIG_MSG="Configuring Debian User & Apps..."
    COMPLETE_MSG="INSTALLATION COMPLETE!"
    HOW_TO="How To Use:"
fi

echo -e "${CYAN}$INSTALL_MSG${NC}"

# 1. Update Termux
pkg update && pkg upgrade -y
pkg install proot-distro pulseaudio termux-x11-nightly -y

# 2. Install Debian
echo -e "${GREEN}$INSTALL_DEBIAN${NC}"
proot-distro install debian

# 3. Setup Alias Global
cp starts.sh $PREFIX/bin/starts
cp stopd.sh $PREFIX/bin/stopd
chmod +x $PREFIX/bin/starts $PREFIX/bin/stopd

# 4. Konfigurasi Debian
USERNAME="Home"
echo -e "${GREEN}$CONFIG_MSG${NC}"

proot-distro login debian -- bash -c "
apt update && apt upgrade -y
apt install xfce4 xfce4-goodies dbus-x11 sudo -y
apt install firefox-esr mpv mousepad pulseaudio -y

useradd -m -s /bin/bash $USERNAME
echo '$USERNAME:1234' | chpasswd
usermod -aG sudo $USERNAME

sudo -u $USERNAME bash -c '
mkdir -p ~/Desktop
cp /usr/share/applications/firefox-esr.desktop ~/Desktop/
cp /usr/share/applications/mpv.desktop ~/Desktop/
cp /usr/share/applications/org.xfce.mousepad.desktop ~/Desktop/
chmod +x ~/Desktop/*.desktop
'
"

# 5. Setup startd
DEBIAN_USER_BIN="$PREFIX/var/lib/proot-distro/installed-rootfs/debian/home/$USERNAME/.local/bin"
mkdir -p "$DEBIAN_USER_BIN"
cp startd.sh "$DEBIAN_USER_BIN/startd"
chmod +x "$DEBIAN_USER_BIN/startd"

proot-distro login debian --user $USERNAME -- bash -c "echo 'export PATH=\$PATH:~/.local/bin' >> ~/.bashrc"

# ==============================
# FINISH MESSAGE
# ==============================

echo -e "${CYAN}==============================================${NC}"
echo -e "${GREEN}$COMPLETE_MSG${NC}"
echo -e "${YELLOW}$HOW_TO${NC}"
echo -e "1. ${CYAN}starts${NC}"
echo -e "2. Open Termux:X11 app"
echo -e "3. ${CYAN}proot-distro login debian --user $USERNAME${NC}"
echo -e "4. ${CYAN}startd${NC}"
echo -e "5. ${CYAN}stopd${NC}"
echo -e "${CYAN}==============================================${NC}"