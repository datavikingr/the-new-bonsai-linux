# dotfiles

my dots for the [berry window manager](https://github.com/JLErvin/berry), based on a [post I saw on reddit](https://www.reddit.com/r/unixporn/comments/vcphbh/berry_pine/). 

the user deleted their account since and never provided their dot files, so I volunteered to rebuild it from the ground up and ended up keeping it as my daily driver on my wife's old 2013 iMac. I'm running this set up on Ubuntu 22.04. I started with the server iso and built up to here. If you'd like to replicate that, seriously consider disabling cloud-init. speeds up boot-time significantly and its a non-critical process.

![dotsimage](https://user-images.githubusercontent.com/43792895/185729686-4baeb80b-ca64-4734-aa96-1f486143b599.png)
the different distros action is powered by [distrobox](https://github.com/89luca89/distrobox)!

# Features:
 - rolling release Ubuntu (big thanks to [wimpysworld](https://github.com/wimpysworld))
 - snap-free, cloud-init free, gnome-free Ubuntu
 - seriously light weight
 - tiling window managers are pretty cool; powered by berry, berrytile
 - flatpak, pacstall, deb-get, homebrew, dnf, pacman, aur packages integrate seemlessly into my application launcher
 - nala is way faster and prettier than apt. don't forget to ```nala fetch```!
 - powerful system admin tools with timeshift, stacer, garted, and mainline
 - custom neofetch, neofetch config

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

# Installation

cd into your desired source folder. for instance, ~/code or ~/src. if you're in Cubic, don't go anywhere, /root is fine & we'll clean it up afterwards. then, the following:

## clone the repo

```
git clone https://github.com/futurehaskins/dotfiles
cd dotfiles
```

## seriously, review the code before running it.

use cat/micro/nano/vim/emacs/whatever to view and edit the script as desired. ```installdots.sh``` is pre-installed systems and ```cubic-install.sh``` is for use in chroot via Cubic.

remove any packages you don't like, and tweak to taste. NOTE: ```cubic-install.sh``` will remove gnome, if it is installed. please comment that out if it's undesired behavior.

## OPTION 1 of 2: run the script for pre-existing Debian-family installation
this script assumes you're working from a pre-existing installation of a Debian-family distro and it will not disrupt your previous desktop(s). It will change your login manager.

```bash installdots.sh``` or ```./installdots.sh```

## OPTION 2 of 2: run the script in chroot/Cubic

this script asssumes you're working from inside a server .iso file via [Cubic](https://github.com/CubicStake/cubic). 

```bash cubic-install.sh``` Or ```./cubic-install.sh```

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

from there, you'll reboot into sddm. select your 'desktop' in the bottom right dialog box - you're looking for berry. sign in, and you're good to go.

# Why?
Who needs backups when they built out their dev environment into a full-featured-enough respin of Ubuntu from scratch? Whether you regard this as a distro or a respin/remix - I did this for three reasons: 
 1. education - it's my first time building a distro/respin, and git bare repos are weird.
 2. to use in production. I'm using it to develop it, to boot, which presents its own challenges, but accelerates testing (and adds stakes).
 3. it's awesome! I'm still blown away that I could do some of this stuff.

# What's next? What's the roadmap?
 1. 1080p monitor support with polybar, I may also tweak colors for more pop.
 2. [cassowary](https://github.com/casualsnek/cassowary), so I can add windows applications to the available software (I need powerBI for work)
 3. chekcing godot's licensing, to see if I'm allowed to include it in the script, and if so, add it!
 4. [wtfutil](https://github.com/wtfutil/wtf) - I have a vertical dashboard config already, I need to make it horizontal and install that.
 5. better GTK/QT theming. looking at thunar is painful.
 6. adding automatic creation of three distroboxes (arch, debian, fedora) to the install scripts. they are not currently included.
 7. update script that updates across all various package managers installed on the host.
 8. a boot splash screen
 9. branding, I guess? it's basically a whole distrubution already, may as well lean into it.
