# 🖥️ Xfce-Proot-Desktop

[🇬🇧 English](#-english) | [🇮🇩 Bahasa Indonesia](#-bahasa-indonesia)

---

# 🇬🇧 English

This repository provides an automated installation script to run the **XFCE4 Desktop Environment** on Android using **Termux**, **Debian PRoot**, and **Termux:X11**.

Unlike the traditional VNC method, this setup uses **Termux:X11**, delivering smoother performance, integrated PulseAudio support, and a more responsive user interface.

## ✨ Features

- **Secure User Management** — Runs as a regular user (not root) for improved stability and security.
- **Preinstalled Applications** — Firefox, MPV Player, and Mousepad included by default.
- **Audio Support** — PulseAudio integration for proper sound output.
- **Desktop Shortcuts** — Quick access icons for essential applications.
- **Session Commands** — Easy-to-use commands: `starts`, `startd`, and `stopd`.

## 📋 Requirements

Before installation, make sure you have:

1. **Termux** (F-Droid version recommended)  
   https://f-droid.org/en/packages/com.termux/

2. **Termux:X11**  
   https://github.com/termux/termux-x11/releases

---

## 🚀 Installation

Run the following command inside Termux:

```bash
pkg update && pkg upgrade -y && pkg install git -y && git clone https://github.com/XZV-Developer/Xfce-Proot-Desktop.git && cd Xfce-Proot-Desktop && chmod +x install-xfce.sh && ./install-xfce.sh
```

# 🇮🇩 Bahasa Indonesia

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
pkg update && pkg upgrade -y && pkg install git -y && git clone https://github.com/XZV-Developer/Xfce-Proot-Dekstop.git && cd Xfce-Proot-Desktop && chmod +x install-xfce.sh && ./install-xfce.sh
```
Jika di suruh masukkan password, password adalah: 1234
