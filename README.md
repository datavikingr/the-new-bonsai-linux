# Bonsai Linux
a more curated linux experience
![dotsimage](https://user-images.githubusercontent.com/43792895/185729686-4baeb80b-ca64-4734-aa96-1f486143b599.png)

this started as my dots for the [berry window manager](https://github.com/JLErvin/berry), based on a [post I saw on reddit](https://www.reddit.com/r/unixporn/comments/vcphbh/berry_pine/), but its kinda become something a little bigger than that. halfway between a rice and a full distro/respin in its own right, it's something... different. 

the original user deleted their account and never provided their dot files, so I volunteered to rebuild it from the ground up and ended up keeping it as my daily driver on my wife's old 2013 iMac, which is now my primary dev environment.

I'm running this set up on Ubuntu 22.04. I started with the server iso and built up to here. If you'd like to replicate that directly, seriously consider disabling cloud-init. speeds up boot-time significantly and its a non-critical process. if you're doing that from within cubic's chroot environment (see below), wait until after the installation is complete to disable to cloud-init with ```sudo touch /etc/cloud/cloud-init.disabled``` and/or uninstalling the snap package.

# Bonsai Linux? Isn't that another distro?
actually, yeah. that's a real deep cut there, homie. bonzai linux "prime" stopped getting developed in 2004. nobody else was using the name, so I picked it up. this project is unrelated to the previous project - but it shares a base (kinda ubuntu/debian) and its drive for minimalism.

# Why?
 - backups - all my personal files are in the cloud, so reinstalling my setup is my primary pain point \~I don't have that problem anymore~
 - education - it's my first time building a distro/respin, so this was a learning experience to say the least. \~git bare repos are W E I R D~
 - production - I'm using bonsai to develop bonsai which presents its own challenges, but accelerates testing. \~and adds stakes! live life on the edge!~
 - awe - I am still amazed by different distros running on the same computer, powered by [distrobox](https://github.com/89luca89/distrobox)! \~I still get the aur!~
 - Arch who? - a rolling release distro that has 'all' the package managers on debian, let alone ubuntu, built from a server iso. \~Bleeding edge stability!~
 - nerd cred - this is nerd-cool and you know it \~tiling window hacker aesthetic~

# Features:
 - rolling release Ubuntu (big thanks to [wimpysworld](https://github.com/wimpysworld) for this absolute power move)
 - snap-free, cloud-init free, gnome-free Ubuntu
 - seriously light weight
 - tiling window managers are pretty cool; powered by berry, berrytile
 - flatpak, pacstall, deb-get, homebrew, and nala bring all of the packages home to roost!
 - seemless dnf, pacman, aur package integration in the application launcher
 - nala is way faster and prettier than apt. don't forget to ```nala fetch```!
 - powerful system admin tools with timeshift, stacer, garted, and mainline
 - custom neofetch, neofetch config (really minimal tweaks, lemme not overstate this)

# App List:
 - sxhkd - hotkeys
 - rofi - program launcher
 - kitty - a lightweight terminal emulator with image support - great for custom neofetch configs!
 - picom - compositor for those pretty rounded edges and transparency
 - feh - background image handler
 - polybar - desktop bar, managaes workspaces and system tray
 - pulseaudio - manages audio
 - dunst - notification daemon
 - zsh - a shell with more features than bash; check out oh-my-zsh for plugins and themes
 - powerline-shell - beautifying the terminal's prompt (compatible with bash & fsh)
 - micro - an command line text editor that uses ctrl+c/v for Copy/Paste like 99.999999% of humanity.
 - sddm - graphical login manager (calling them display managers is confusing)
 - thunar - file manager
 - notepadqq - a GUI text editor and 'clone' of Notepad++
 - scrot - scriptable screen capturing, from the terminal
 - lolcat - rainbowify all your terminal output by piping it into this
 - nala - a front end for apt that supports parallel downloads out of the box; check out nala-fetch (included in the base package)!
 - pacstall - the AUR for Ubuntu-family distros
 - deb-get - third party .deb support (discord), so no fumbling around the web trying to find the right file!
 - homebrew - Mac's missing package manager - that works great on Linux, too!
 - timeshift - Super-powerful backup and restore application.
 - stacer - GUI top/htop, but on steroids with a sleek and modern UX/UI.
 - mainline - kernel management in the Debian family that doesn't hurt? yes, please, mate!
 - distrobox - distro-hopping is for suckers. Supports client GUI apps running on the host!! This is seriously magic!!
 - godot - the best, free game engine on the market - and that was before unity shot themselves both of their feet
 
# Roadmap:
 1.  gather and provide all of the licenses in one easy-to-access folder. Better than hunting them down online each time.
 2.  1080p monitor support with polybar, I may also tweak colors for more pop.
 3.  [cassowary](https://github.com/casualsnek/cassowary), so I can add windows applications to the available software (I need powerBI for work)
 4.  chekcing godot's licensing, to see if I'm allowed to include it in the script, and if so, add it!
 5.  [wtfutil](https://github.com/wtfutil/wtf) - I have a vertical dashboard config already, I need to make it horizontal and install that.
 6.  better GTK/QT theming. looking at thunar is painful.
 7.  adding automatic creation of three distroboxes (arch, debian, fedora) to the install scripts. they are not currently included.
 8.  update script that updates across all various package managers installed on the host.
 9.  a boot splash screen
 10. branding, I guess? it's basically a whole distrubution already, may as well lean into it.

# Installation Method 1: installdots.sh - for trying a new desktop from an already installed Debian-family distro
cd into your desired source folder; for instance, ~/code or ~/src. 

```
git clone https://github.com/futurehaskins/dotfiles
cd dotfiles
```
seriously, review the code before running it. use nano/vim/emacs/whatever to get in and review the script. remove any packages you don't like, and tweak to taste. this is a recipe, not a calibration methodology; meaning, it should be edited to personal taste.
```
./installdots.sh
```
when that completes, restart.
```
sudo systemctl restart
```
the sddm theme has the desktop drop down in the bottom right corner of the screen. Select 'berry' and login. your old desktop will still be there - just logout/login and select your old desktop in the selector.

# Installation Method 2: cubic-install.sh - for building out your own insatllation media
install cubic, if you haven't already.
download your preferred iso file from the debian-family of distros.
open cubic, continue until you find yourself in a terminal.
```
git clone https://github.com/futurehaskins/dotfiles
cd dotfiles
./cubic-install.sh
```
click continue in the top right of cubic's window, finish it up, and flash it on to a thumbdrive. install it like you would any other distro.
