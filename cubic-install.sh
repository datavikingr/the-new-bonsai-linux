#!/bin/bash

# cubic-install.sh - Written by Alex Haskins

#init
repofolder=$(pwd)
apt update
clear

#kill snap
systemctl stop snapd
apt remove --purge snapd -y
rm -rf ~/snap/
rm -rf /var/cache/snapd/

#kill cloud-init
touch /etc/cloud/cloud-init.disabled

#kill gnome, if present
apt remove --purge gdm3 gnome-shell -y
apt automremove

#berry and dependencies
apt install wget curl libx11-dev libxft-dev libxinerama-dev -y
wget https://github.com/barnumbirr/berry-debian/releases/download/v0.1.11-1/berry_0.1.11-1_amd64_bullseye.deb
dpkg -i berry_0.1.11-1_amd64_bullseye.deb
rm berry_0.1.11-1_amd64_bullseye.deb
rm -rf /usr/share/xsessions/
mv .config/berry/berry.desktop /usr/share/xsessions/berry.desktop
apt install sxhkd polybar rofi picom feh pulseaudio dunst xterm kitty thunar python3 python3-pip -y

#sddm and dependencies
apt install sddm qml-module-qtquick-layouts qml-module-qtquick-controls2 qml-module-qtquick-templates2 qml-module-qtgraphicaleffects -y
cp .config/sddm/etc-sddm.conf /etc/sddm.conf
cp -r .config/sddm/mount/* /usr/share/sddm/themes/mount/

#cli system tools
apt install zsh micro ranger docker nala htop bmon -y

#cli fun
apt install lolcat neofetch gnugo gnuchess cbonsai cmatrix fortune-mod nethack-console -y

#flatpak
apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#gui system utilities
add-apt-repository ppa:oguzhaninan/stacer -y
add-apt-repository ppa:cappelikan/ppa
apt-get update
apt-get install notepadqq scrot timeshift gparted stacer mainline -y
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | /bin/bash

#homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#pacstall
bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"

#deb-get
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | bash -s install deb-get
deb-get install brave-browser discord

#powerline
pip install powerline-shell

#bashrc
touch /etc/skel/.bashrc
cat << EOF > /etc/skel/.bashrc
#local binaries
export $PATH="$HOME/.local/bin/:$PATH"
#Powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
	}

	if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
	fi
alias ls='ls -pash --color=auto'
alias neofetch='neofetch | lolcat'
alias ..='cd ..'
alias bonsai='cbonsai -S'
alias news='curl us.getnews.tech'
alias weather='curl wttr.in/~Joppa+MD'
alias moon='curl wttr.in/Moon'
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
neofetch | lolcat
EOF

#zshrc
touch /etc/skel/.zshrc
cat << EOF > /etc/skel/.zshrc
#local binaries
export $PATH="$HOME/.local/bin/:$PATH"
#Powerline-shell
function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
alias ls='ls -pash --color=auto'
alias neofetch='neofetch | lolcat'
alias ..='cd ..'
alias bonsai='cbonsai -S'
alias news='curl us.getnews.tech'
alias weather='curl wttr.in/~Joppa+MD'
alias moon='curl wttr.in/Moon'
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
neofetch | lolcat
EOF

#return to repo and distribute config files
cd $repofolder
cp .fehbg /etc/skel
rm -rf .config/sddm/
cp -r .config/ /etc/skel/
cp -r .local/bin/ /etc/skel/

#cleanup
cd ..
rm -r dotfiles/
apt autoremove -y
apt autoclean -y
apt update 
apt upgrade -y