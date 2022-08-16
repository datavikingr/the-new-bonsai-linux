#!/bin/bash

# Written by Alex Haskins

#Dependencies
clear
sudo systemctl stop snapd
sudo apt remove --purge snapd -y
rm -rf ~/snap/
sudo rm -rf /var/cache/snapd/
sudo touch /etc/cloud/cloud-init.disabled
sudo apt update
sudo apt install wget curl libx11-dev libxft-dev libxinerama-dev -y
wget -o berry.deb https://github.com/barnumbirr/berry-debian/releases/download/v0.1.11-1/berry_0.1.11-1_amd64_bullseye.deb
sudo dpkg -i berry.deb
sudo apt install sxhkd rofi kitty picom feh polybar pulseaudio dunst xterm python3 python3-pip -y
rm berry.deb
sudo touch /usr/share/xsessions/berry.desktop

## TODO: This needs a test to check for whether sudo is required or where/how

sudo mv ./.config/berry/berry.desktop /usr/share/xsessions/berry.desktop
read -p "Would you like to install the optional packages? (y/n)" optpack
if [["$optpack" == "n"]]; then
	exit 0
else
	sudo apt install zsh micro ranger sddm thunar notepadqq scrot lolcat docker neofetch nala timeshift gnugo gnuchess htop bmon cbonsai cmatrix fortune -y
	sudo apt install flatpak -y
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	pip install powerline-shell
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
	sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
	curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	sudo deb-get install brave-browser discord
	sudo add-apt-repository ppa:oguzhaninan/stacer -y
	sudo add-apt-repository ppa:cappelikan/ppa
	sudo apt-get update
	sudo apt-get install stacer mainline -y
	sudo add-apt-repository -remove ppa:oguzhaninan/stacer
	sudo add-apt-repository -remove ppa:cappelikan/ppa
	curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
	rm ./README.md
	rm ./LICENSE
	sudo cp ~/.config/sddm/mount/* /usr/share/sddm/themes/mount/
	sudo cp /etc/sddm.conf .config/sddm/sddm-backup.conf
	sudo cp ~/.config/sddm/etc-sddm.conf /etc/sddm.conf
	cp * $HOME/
fi
