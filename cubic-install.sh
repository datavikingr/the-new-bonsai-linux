#!/bin/bash

# cubic-install.sh - Written by Alex Haskins
# considers ubuntu-22.04-live-server-amd64.iso as base

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
apt install wget curl apt-utils libx11-dev libxft-dev libxinerama-dev -y
wget https://github.com/barnumbirr/berry-debian/releases/download/v0.1.11-1/berry_0.1.11-1_amd64_bullseye.deb
dpkg -i berry_0.1.11-1_amd64_bullseye.deb
rm berry_0.1.11-1_amd64_bullseye.deb
rm -rf /usr/share/xsessions/
mv .config/berry/berry.desktop /usr/share/xsessions/
apt install sxhkd polybar rofi picom feh pulseaudio dunst xterm kitty thunar python3 python3-pip -y

#sddm and dependencies
apt install sddm qml-module-qtquick-layouts qml-module-qtquick-controls2 qml-module-qtquick-templates2 qml-module-qtgraphicaleffects -y
cp .config/sddm/etc-sddm.conf /etc/sddm.conf
cp -r .config/sddm/mount/* /usr/share/sddm/themes/mount/
systemctl enable sddm.service

#cli system tools
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
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
alias weather='curl wttr.in'
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
alias weather='curl wttr.in'
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

#adding some rolling rhino to the mix
OS_CODENAME=$(lsb_release --codename --short)
HOST_ARCH="$(uname --machine)"
if [ "${HOST_ARCH}" == "x86_64" ]; then
	ARCHIVE="http://archive.ubuntu.com/ubuntu"
	SEC_ARCHIVE="http://security.ubuntu.com/ubuntu"
else
	ARCHIVE="http://ports.ubuntu.com/ubuntu-ports"
	SEC_ARCHIVE="http://ports.ubuntu.com/ubuntu-ports"
fi
cp  /etc/apt/sources.list /etc/apt/sources.list.${OS_CODENAME}
cat << EOF > /etc/apt/sources.list
# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.
deb ${ARCHIVE} devel main restricted
# deb-src ${ARCHIVE} devel main restricted
## Major bug fix updates produced after the final release of the
## distribution.
deb ${ARCHIVE} devel-updates main restricted
# deb-src ${ARCHIVE} devel-updates main restricted
## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb ${ARCHIVE} devel universe
# deb-src ${ARCHIVE} devel universe
deb ${ARCHIVE} devel-updates universe
# deb-src ${ARCHIVE} devel-updates universe
## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb ${ARCHIVE} devel multiverse
# deb-src ${ARCHIVE} devel multiverse
deb ${ARCHIVE} devel-updates multiverse
# deb-src ${ARCHIVE} devel-updates multiverse
## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb ${ARCHIVE} devel-backports main restricted universe multiverse
# deb-src ${ARCHIVE} devel-backports main restricted universe multiverse
## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
# deb http://archive.canonical.com/ubuntu devel partner
# deb-src http://archive.canonical.com/ubuntu devel partner
deb ${SEC_ARCHIVE} devel-security main restricted
# deb-src ${SEC_ARCHIVE} devel-security main restricted
deb ${SEC_ARCHIVE} devel-security universe
# deb-src ${SEC_ARCHIVE} devel-security universe
deb ${SEC_ARCHIVE} devel-security multiverse
# deb-src ${SEC_ARCHIVE} devel-security multiverse
EOF

#cleanup
cd ..
rm -r dotfiles/
apt autoremove -y
apt autoclean -y
apt update 
apt upgrade -y