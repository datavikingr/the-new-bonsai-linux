# dotfiles

My dots for the [berry window manager](https://github.com/JLErvin/berry), based on a [post I saw on reddit](https://www.reddit.com/r/unixporn/comments/vcphbh/berry_pine/). 

The user deleted their account since and never provided their dot files, so I volunteered to rebuild it from the ground up and ended up keeping it as my daily driver on my wife's old 2013 iMac. I'm running this set up on Ubuntu 22.04. I started with the server iso and built up to here. If you'd like to replicate that, seriously consider disabling cloud-init. Speeds up boot-time significantly and its a non-critical process.

![dotsimage](https://user-images.githubusercontent.com/43792895/185729686-4baeb80b-ca64-4734-aa96-1f486143b599.png)
The different distros action is powered by [distrobox](https://github.com/89luca89/distrobox)!

# Dependencies:
## Manadatory:
 - sxhkd - hotkeys
 - rofi - program launcher
 - kitty - a lightweight terminal emulator with image support - great for custom neofetch configs!
 - picom - compositor for those pretty rounded edges and transparency
 - feh - background image handler
 - polybar - desktop bar, managaes workspaces and system tray
 - pulseaudio - manages audio
 - dunst - notification daemon

## Optional:
 - zsh - a shell more features than bash; check out oh-my-zsh for plugins and themes
 - powerline-shell - beautifying the terminal's prompt (compatible with bash & fsh)
 - micro - an command line text editor that uses ctrl+c/v for Copy/Paste like 99.999999% of humanity.
 - sddm - graphical login manager (calling them display managers is confusing)
 - thunar - file manager
 - notepadqq - a GUI text editor and 'clone' of Notepad++
 - scrot - screen capture, from the terminal
 - lolcat - rainbowify all your terminal output by piping it into this
 - nala - a front end for apt that supports parallel downloads out of the box; check out nala-fetch (included in the base package)!
 - pacstall - the AUR for Ubuntu-family distros
 - deb-get - third party .deb support (discord), so no fumbling around the web trying to find the right file!
 - homebrew - Mac's missing package manager - that works great on Linux, too!
 - timeshift - Super-powerful backup and restore application.
 - stacer - GUI top/htop, but on steroids with a sleek and modern UX/UI.
 - mainline - kernel management in the Debian family that doesn't hurt? yes, please, mate!
 - distrobox - distro-hopping is for suckers. Supports client GUI apps running on the host!! This is seriously magic!!

# Installation in existing Debian-family install

cd into your desired source folder. For instance, ~/code or ~/src. Then, the following:

## clone the repo

```
git clone https://github.com/futurehaskins/dotfiles
cd dotfiles
```

## seriously, review the code before running it.
```
cat installdots.sh
```

## use nano/vim/emacs/whatever to edit the script as desired.
Most of it is structural, but you might only like some of the optional packages. Feel free to comment them out.

## OPTION 1 of 2: run the script for pre-existing Debian-family installation
This script assumes you're working from a pre-existing installation of a Debian-family distro and it will not disrupt your previous desktop(s). It will change your login manager.

```
bash installdots.sh
``` 
Or
```
./installdots.sh
```

## OPTION 2 of 2: run the script in chroot/Cubic

This script asssumes you're working from a server .iso file. Edit to taste. If gnome is installed, it will remove it. I use this in production, you should comment that out if it is undesired behavior.  The intended use here is a lightweight, but relatively full-featured 'desktop environment' built from scratch.

```
bash cubic-install.sh
``` 
Or
```
./cubic-install.sh
```

## add wifi.sh to sign into wifi
```
cd ~/.config/berry
micro wifi.sh
```

and input the following:
```
#!/bin/bash

nmcli r wifi on &
nmcli wifi connect 'Your wifi's SSID (name) here' password 'your wifi's password here'
```

## finally, restart
```
sudo systemctl restart
```

From there, you'll reboot into sddm. select your 'desktop' in the bottom right dialog box - you're looking for berry. Sign in, and you're good to go.
