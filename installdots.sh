#!/bin/bash

# installdots.sh - Written by Alex Haskins

#init
repofolder=$(pwd)
sudo apt update
clear

#berry and dependencies
sudo apt install wget curl apt-utils libx11-dev libxft-dev libxinerama-dev -y
wget https://github.com/barnumbirr/berry-debian/releases/download/v0.1.11-1/berry_0.1.11-1_amd64_bullseye.deb
sudo dpkg -i berry_0.1.11-1_amd64_bullseye.deb
rm berry_0.1.11-1_amd64_bullseye.deb
mv .config/berry/berry.desktop /usr/share/xsessions/
sudo apt install sxhkd polybar rofi picom feh pulseaudio dunst xterm kitty python3 python3-pip -y

#sddm and dependencies
sudo apt install sddm qml-module-qtquick-layouts qml-module-qtquick-controls2 qml-module-qtquick-templates2 qml-module-qtgraphicaleffects -y
sudo cp .config/sddm/etc-sddm.conf /etc/sddm.conf
sudo cp -r .config/sddm/mount/* /usr/share/sddm/themes/mount/
sudo systemctl enable sddm.service

#cli system tools
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt install zsh nala -y

#cli fun
sudo apt install lolcat -y

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
