#!/data/data/com.termux/files/usr/bin/bash

# Warna agar terminal estetik
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${CYAN}Starting Debian XFCE Installation for Termux:X11...${NC}"

# 1. Update dan Install Dependencies di Termux
pkg update && pkg upgrade -y
pkg install proot-distro pulseaudio termux-x11-nightly -y

# 2. Install Debian
echo -e "${GREEN}Installing Debian...${NC}"
proot-distro install debian

# 3. Setup Alias di Termux (Global Commands)
# Memindahkan file starts.sh dan stopd.sh milikmu ke bin
cp starts.sh $PREFIX/bin/starts
cp stopd.sh $PREFIX/bin/stopd
chmod +x $PREFIX/bin/starts $PREFIX/bin/stopd

# 4. Konfigurasi Sistem di dalam Debian (Root Mode)
USERNAME="Home"
echo -e "${GREEN}Configuring Debian User & Apps...${NC}"

proot-distro login debian -- bash -c "
apt update && apt upgrade -y
# Install Desktop & Apps sesuai request
apt install xfce4 xfce4-goodies dbus-x11 sudo -y
apt install firefox-esr mpv mousepad pulseaudio -y

# Membuat User Baru (non-root)
useradd -m -s /bin/bash $USERNAME
echo '$USERNAME:1234' | chpasswd
usermod -aG sudo $USERNAME

# Membuat folder Desktop dan memindahkan shortcut aplikasi
sudo -u $USERNAME bash -c '
mkdir -p ~/Desktop
cp /usr/share/applications/firefox-esr.desktop ~/Desktop/
cp /usr/share/applications/mpv.desktop ~/Desktop/
cp /usr/share/applications/org.xfce.mousepad.desktop ~/Desktop/
chmod +x ~/Desktop/*.desktop
'
"

# 5. Memasukkan startd.sh ke dalam Debian User
# Folder bin lokal untuk user agar rapi
DEBIAN_USER_BIN="$PREFIX/var/lib/proot-distro/installed-rootfs/debian/home/$USERNAME/.local/bin"
mkdir -p "$DEBIAN_USER_BIN"
cp startd.sh "$DEBIAN_USER_BIN/startd"
chmod +x "$DEBIAN_USER_BIN/startd"

# Pastikan folder tersebut masuk ke PATH user Debian
proot-distro login debian --user $USERNAME -- bash -c "echo 'export PATH=\$PATH:~/.local/bin' >> ~/.bashrc"

echo -e "${CYAN}==============================================${NC}"
echo -e "${GREEN}INSTALLATION COMPLETE!${NC}"
echo -e "${YELLOW}Cara Pakai:${NC}"
echo -e "1. Di Termux, ketik: ${CYAN}starts${NC}"
echo -e "2. Buka aplikasi Termux:X11 di Android."
echo -e "3. Masuk ke Debian: ${CYAN}proot-distro login debian --user $USERNAME${NC}"
echo -e "4. Di dalam Debian, ketik: ${CYAN}startd${NC}"
echo -e "5. Untuk mematikan, ketik: ${CYAN}stopd${NC} di Termux."
echo -e "${CYAN}==============================================${NC}"