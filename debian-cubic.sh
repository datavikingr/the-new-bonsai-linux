#!/bin/bash

# cubic-install.sh - Written by Alex Haskins
# considers debian-live-11.5.0-amd64-kde+nonfree.iso its base.
# download here: https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.5.0-live+nonfree/amd64/iso-hybrid/

# init
apt update

#berry and dependencies
apt install wget curl apt-utils libx11-dev libxft-dev libxinerama-dev -y
wget https://github.com/barnumbirr/berry-debian/releases/download/v0.1.11-1/berry_0.1.11-1_amd64_bullseye.deb
dpkg -i berry_0.1.11-1_amd64_bullseye.deb
rm berry_0.1.11-1_amd64_bullseye.deb
mv .config/berry/berry.desktop /usr/share/xsessions/
apt install sxhkd polybar rofi picom feh pulseaudio dunst xterm kitty thunar python3 python3-pip lxappearance -y
cp .config/sddm/etc-sddm.conf /etc/sddm.conf
mkdir -p /usr/share/sddm/themes/mount/
cp -r .config/sddm/mount/* /usr/share/sddm/themes/mount/
systemctl enable sddm.service

#cli system tools
