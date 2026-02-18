#!/data/data/com.termux/files/usr/bin/bash

# Bersihkan sisa proses & lock file lama agar tidak bentrok
killall -9 termux-x11 pulseaudio proot-distro 2>/dev/null
rm -rf $TMPDIR/.X*-lock $TMPDIR/.X11-unix

# Jalankan Audio (Opsional tapi disarankan agar YouTube ada suara)
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Jalankan X11 Server
export XDG_RUNTIME_DIR=$TMPDIR
termux-wake-lock
termux-x11 :0 -ac &

echo "Server Termux:X11 Ready!"
echo "Silakan buka aplikasi Termux:X11 lalu login ke Debian."
