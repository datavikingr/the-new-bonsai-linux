# dotfiles

My dots for the [berry window manager](https://github.com/JLErvin/berry), based on a [post I saw on reddit](https://www.reddit.com/r/unixporn/comments/vcphbh/berry_pine/). 

The user deleted their account since and never provided their dot files, so I volunteered to rebuild it from the ground up and ended up keeping it as my daily driver on my wife's old 2013 iMac. I'm running this set up on Ubuntu 22.04. I started with the server iso and built up to here. If you'd like to replicate that, seriously consider disabling cloud-init. Speeds up boot-time significantly and its a non-critical process.

![2022-08-11-131802_2560x1440_scrot](https://user-images.githubusercontent.com/43792895/184194660-5a87fc39-6aa5-4ec6-9ad0-a4d1e02d5469.png)
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
