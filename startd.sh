#!/bin/bash

# Setup Environment sesuai temuanmu yang berhasil
export DISPLAY=:0
export LIBGL_ALWAYS_SOFTWARE=1
export PULSE_SERVER=127.0.0.1
export XDG_RUNTIME_DIR=/tmp

# Pastikan folder tmp bersih dari lock file hantu
sudo rm -rf /tmp/.X*-lock /tmp/.X11-unix

# Buat link socket agar Debian bisa melihat layar Termux
ln -s /data/data/com.termux/files/usr/tmp/.X11-unix /tmp/.X11-unix 2>/dev/null

echo "Launching Desktop Environment..."
dbus-run-session xfce4-session
