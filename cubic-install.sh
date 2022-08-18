#!/bin/bash

# cubic-install.sh - Written by Alex Haskins

## WARNING ##
# This script assumes that you are in a chroot environment and signed in as root, via Cubic in theory, editing .iso files.
# If you're looking for the server/baremetal version of the script, use installdots.sh instead.

#Dependencies
clear
repofolder=$(pwd)
systemctl stop snapd
apt remove --purge snapd -y
rm -rf ~/snap/
rm -rf /var/cache/snapd/
touch /etc/cloud/cloud-init.disabled
apt update
apt remove --purge gdm3 -y
apt install wget curl libx11-dev libxft-dev libxinerama-dev -y
wget https://github.com/barnumbirr/berry-debian/releases/download/v0.1.11-1/berry_0.1.11-1_amd64_bullseye.deb
dpkg -i berry_0.1.11-1_amd64_bullseye.deb
apt install sxhkd rofi kitty picom feh polybar pulseaudio dunst xterm python3 python3-pip -y
rm berry_0.1.11-1_amd64_bullseye.deb
mv .config/berry/berry.desktop /usr/share/xsessions/berry.desktop
rm /usr/share/xsessions/ubuntu.desktop
read -p "Would you like to install the optional packages? (y/n)" optpack
if [["$optpack" == "n"]]; then
	exit 0
else
	apt install zsh micro ranger sddm thunar notepadqq scrot lolcat docker neofetch nala timeshift gnugo gnuchess htop bmon cbonsai cmatrix fortune-mod -y
	apt install flatpak -y
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	pip install powerline-shell
  cd /etc/skel
	#Adding powerline to bash, if that's your preferred shell
	cat << EOF > .bashrc
	#making sure your local binaries are accounted for
	export $PATH="$HOME/.local/bin/:$PATH"

	#Powerline-shell
	function _update_ps1() {
	    PS1=$(powerline-shell $?)
		}
	
		if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
	    	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
		fi

	neofetch | lolcat &
	EOF
	#AND!!! Adding it to zshrc as well, in case that's your desired shell, we installed it above. oh-my-zsh is on you, though.
	cat << EOF > .zshrc
	#making sure your local binaries are accounted for
	export $PATH="$HOME/.local/bin/:$PATH"

	#Powerline-shell
	function _update_ps1() {
		    PS1=$(powerline-shell $?)
		}
		
		if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
		    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
		fi

		neofetch | lolcat &
	EOF
  
  ####HERE
  
	#I know this is scary. It's just pacstall. You can verify my copy/paste from their github page.
	bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
	#Same here, but this one is deb-get
	curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | bash -s install deb-get
	#And this one is Homebrew, which you can check out via their homepage.
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	deb-get install brave-browser discord
	add-apt-repository ppa:oguzhaninan/stacer -y
	add-apt-repository ppa:cappelikan/ppa
	apt-get update
	apt-get install stacer mainline -y
	add-apt-repository -remove ppa:oguzhaninan/stacer
	add-apt-repository -remove ppa:cappelikan/ppa
	curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | /bin/bash
	rm ./README.md
	rm ./LICENSE
	cp .config/sddm/mount/* /usr/share/sddm/themes/mount/
	cp /etc/sddm.conf .config/sddm/sddm-backup.conf
	cp .config/sddm/etc-sddm.conf /etc/sddm.conf
	cp * /etc/skel
fi

###########################################################################
# Uncomment the below if you're looking to remove GNOME desktop, as well
#
# apt remove --purge gnome-shell -y

apt autoremove; apt autoclean
apt update; apt upgrade -y
