# 🖥️ Xfce-Proot-Desktop

Repository ini menyediakan script instalasi otomatis untuk menjalankan **XFCE4 Desktop Environment** di Android menggunakan **Termux**, **Debian PRoot**, dan **Termux:X11**. 

Berbeda dengan metode VNC tradisional, metode ini menggunakan **Termux:X11** yang menawarkan performa lebih mulus, dukungan audio melalui PulseAudio, dan user interface yang lebih responsif.

## ✨ Fitur Utama
* **User Management**: Tidak berjalan sebagai root, sehingga lebih aman dan stabil.
* **Apps Ready**: Terpasang Firefox, MPV Player, dan Mousepad secara default.
* **Audio Support**: Terintegrasi dengan PulseAudio agar suara keluar dari speaker HP.
* **Easy Shortcuts**: Desktop icons untuk aplikasi favorit langsung di layar depan.
* **Global Commands**: Perintah praktis `starts`, `startd`, dan `stopd` untuk manajemen sesi.

## 📋 Prasyarat
Sebelum memulai, pastikan kamu sudah menginstal:
1.  [Termux](https://f-droid.org/en/packages/com.termux/) (Versi F-Droid sangat disarankan).
2.  [Termux:X11](https://github.com/termux/termux-x11/releases) (Download .apk di bagian *Actions* atau *Releases*).

---

## 🚀 Cara Instalasi

Cukup jalankan satu baris perintah ini di terminal Termux kamu:

```bash
pkg update && pkg upgrade -y && pkg install git -y && git clone [https://github.com/USERNAME_KAMU/Xfce-Proot-Desktop](https://github.com/USERNAME_KAMU/Xfce-Proot-Desktop) && cd Xfce-Proot-Desktop && chmod +x install.sh && ./install.sh
