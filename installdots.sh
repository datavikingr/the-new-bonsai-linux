#!/bin/bash

# installdots.sh - Written by Alex Haskins
# written as an install package 

#init
repofolder=$(pwd)
sudo apt update
clear

#kill snap
sudo systemctl stop snapd
sudo apt remove --purge snapd -y
rm -rf ~/snap/
sudo rm -rf /var/cache/snapd/

#kill cloud-init
sudo touch /etc/cloud/cloud-init.disabled

#berry and dependencies
sudo apt install wget curl apt-utils libx11-dev libxft-dev libxinerama-dev -y
wget https://github.com/barnumbirr/berry-debian/releases/download/v0.1.11-1/berry_0.1.11-1_amd64_bullseye.deb
sudo dpkg -i berry_0.1.11-1_amd64_bullseye.deb
rm berry_0.1.11-1_amd64_bullseye.deb
mv .config/berry/berry.desktop /usr/share/xsessions/
sudo apt install sxhkd polybar rofi picom feh pulseaudio dunst xterm kitty thunar python3 python3-pip -y

#sddm and dependencies
sudo apt install sddm qml-module-qtquick-layouts qml-module-qtquick-controls2 qml-module-qtquick-templates2 qml-module-qtgraphicaleffects -y
sudo cp .config/sddm/etc-sddm.conf /etc/sddm.conf
sudo cp -r .config/sddm/mount/* /usr/share/sddm/themes/mount/
sudo systemctl enable sddm.service

#cli system tools
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt install zsh micro ranger docker nala htop bmon -y

#cli fun
sudo apt install lolcat neofetch gnugo gnuchess cbonsai cmatrix fortune-mod nethack-console -y

#flatpak
sudo apt install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#gui system utilities
sudo add-apt-repository ppa:oguzhaninan/stacer -y
sudo add-apt-repository ppa:cappelikan/ppa
sudo apt-get update
sudo apt-get install notepadqq scrot timeshift gparted stacer mainline -y
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | /bin/bash

#homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#pacstall
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"

#deb-get
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
sudo deb-get install brave-browser discord

#powerline
pip install powerline-shell

#bashrc

cat << EOF > ~/.bashrc
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
cat << EOF > ~/.zshrc
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
alias weather='curl wttr.it'
alias moon='curl wttr.in/Moon'
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
neofetch | lolcat
EOF

#return to repo and distribute config files
cd $repofolder
cp .fehbg $HOME
rm -rf .config/sddm/
cp -r .config/ $HOME
cp -r .local/bin/ $HOME

#cleanup
rm -r ../dotfiles/
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt update 
sudo apt upgrade -y