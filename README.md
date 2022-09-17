# Bonsai Linux
Grow the branches you like

![image](https://user-images.githubusercontent.com/43792895/190839402-ffac44e7-b91f-4c40-8b06-3311b66c2dfe.png)

this started as my dots for the [berry window manager](https://github.com/JLErvin/berry), based on a [post I saw on reddit](https://www.reddit.com/r/unixporn/comments/vcphbh/berry_pine/), but its kinda become something a little bigger than that. halfway between a rice and a full distro/respin in its own right, it's something... different. the original user deleted their account and never provided their dot files, so I volunteered to rebuild it from the ground up and ended up keeping it as my daily driver on my wife's old 2013 iMac, which is now my primary dev environment.

# Bonsai Linux - why that name?
actually, yeah. that's a real deep cut there, mate. bonzai linux "prime" stopped getting developed in 2004. nobody else was using the name, so I picked it up. this project is unrelated to the previous project. I picked that name because you cultivate the branch(es) you prefer. whether it's debian, fedora, arch, or another distro you grafted onto the trunk, you decide what to build. and whatever you do decide to grow, seemlessly integrates with the trunk (the Ubunbtu-berry core), even GUI applications.

# Why?
 - backups - all my personal files are in the cloud, so reinstalling my setup is my primary pain point 
 - education - it's my first time building a distro/respin, so this was a learning experience to say the least.
 - production - I'm using bonsai to develop bonsai which presents its own challenges, but accelerates testing.
 - awe - I am still amazed by different distros running on the same computer, powered by [distrobox](https://github.com/89luca89/distrobox)!
 - nerd cred - this is nerd-cool and you know it.

# Features:
 - snap-free, cloud-init free, gnome-free Ubuntu for the trunk
   - nala front-end for apt for faster updates
   - flatpak, pacstall, deb-get, pip and homebrew for maximal package access
 - arch, debian, and fedora as the default branches from the trunk
   - seemless dnf, pacman, aur package integration into the system
 - seriously light weight micro-desktop berry window manager
   - preconfigured sxhkd, with sane keybinds and 10 desktops
 - powerful system admin tools with timeshift, stacer, garted, and mainline
   - kernel-level management, even in ubuntu
 
# Roadmap & Notes:
 1.  ~Licenses gathered and held in local directory~ COMPLETE
 2.  ~Better polybar design, more pop~ COMPLETE
 3.  ~[cassowary](https://github.com/casualsnek/cassowary)~ NON-VIABLE
 4.  ~add Godot to both scripts~ COMPLETE
 5.  [wtfutil](https://github.com/wtfutil/wtf): add a default dashboard
 6.  better GTK/QT theming
 7.  ~adding automatic creation of three distroboxes (arch, debian, fedora) to the install scripts.~ COMPLETE
 8.  write update script that updates across all various package managers installed on the trunk.
 9.  a boot splash screen - Plymouth???
 10. npm? ruby's gems? maybe some other package managers?
 11. branding, I guess? it's basically a whole distrubution already, may as well lean into it.
 12. ~terminal color design and themes~

# App Suite:
 - sxhkd - hotkeys
 - rofi - program launcher
 - picom - compositor for those pretty rounded edges and transparency
 - feh - background image handler
 - polybar - desktop bar, managaes workspaces and system tray
 - pulseaudio - manages audio
 - dunst - notification daemon
 - zsh - a shell with more features than bash; check out oh-my-zsh for plugins and themes
 - powerline-shell - beautifying the terminal's prompt (compatible with bash & fsh)
 - micro - an command line text editor that uses ctrl+c/v for Copy/Paste like 99.999999% of humanity.
 - scrot - scriptable screen capturing, from the terminal
 - lolcat - rainbowify all your terminal output by piping it into this
 - nala - a front end for apt that supports parallel downloads out of the box; check out nala-fetch (included in the base package)!
 - pacstall - the AUR for Ubuntu-family distros
 - deb-get - third party .deb support (discord), so no fumbling around the web trying to find the right file!
 - homebrew - Mac's missing package manager - that works great on Linux, too!
 - sddm - graphical login manager (calling them display managers is confusing)
 - distrobox - client GUI apps running on the host!! This is seriously magic!!
 - kitty - a lightweight terminal emulator with image support - great for custom neofetch configs!
 - thunar - file manager
 - notepadqq - a GUI text editor and 'clone' of Notepad++
 - godot - game engine and dev suite
 - brave  - I prefer it to firefox and chrome
 - timeshift - Super-powerful backup and restore application.
 - stacer - GUI top/htop, but on steroids with a sleek and modern UX/UI.
 - mainline - kernel management in the Debian family that doesn't hurt? yes, please, mate!

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
