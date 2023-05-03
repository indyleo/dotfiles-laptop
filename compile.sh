#!/bin/env bash

# Script Variables
builddir=$(pwd)

# Making directories & files 
mkdir -p ~/Github ~/Img ~/Applications ~/Zsh/Plugins ~/Pictures/Screenshots ~/Scripts ~/.icons ~/.themes ~/.cache/zsh ~/.local/bin ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Videos ~/.config
touch ~/.cache/zsh/history 

# Shell Color Scripts
cd ~/Github
git clone https://gitlab.com/dwt1/shell-color-scripts.git
cd shell-color-scripts
sudo make install
sudo cp completions/_colorscript /usr/share/zsh/site-functions
cd ~

# Rofi Calc
cd ~/Github
git clone https://github.com/Mange/rofi-emoji.git
cd rofi-emoji
autoreconf -i
mkdir build
cd build/
../configure
make
sudo make install
cd ~

# Rofi Emoji
cd ~/Github
git clone https://github.com/svenstaro/rofi-calc.git
cd rofi-calc
autoreconf -i
mkdir build
cd build/
../configure
make
make install
cd ~

# Installing moar pager
wget https://github.com/walles/moar/releases/download/v1.13.0/moar-v1.13.0-linux-386 
chmod a+x moar-*-*-*
mv moar-*-*-* ~/.local/bin/moar

# Installing go stuff
go install github.com/jesseduffield/lazygit@latest github.com/xxxserxxx/gotop/v4/cmd/gotop@latest

# Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Moving And Deletig And Adding Files
cd $builddir
git clone https://github.com/indyleo/Wallpapers.git ~/Pictures/Wallpapers/
mv autostart-scripts sxhkd polybar neofetch nvim ranger picom awesome kitty rofi starship.toml mimeapps.list user-dirs.dirs greenclip.toml ~/.config/
rm ~/.bashrc ~/.profile ~/.zshenv
mv .bashrc .zshrc .zshenv .aliasrc .xsession .profile .xinitrc .Xresources ~/
mv $builddir/scripts/wifimenu $builddir/scripts/powermenu ~/.local/bin/

# Zsh Autopairs
cd ~/Zsh/Plugins
git clone https://github.com/hlissner/zsh-autopair.git
cd ~ 

# Zsh You Should Use
cd ~/Zsh/Plugins
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git
cd ~ 

# Zsh Completions
cd ~/Zsh/Plugins
git clone https://github.com/zsh-users/zsh-completions.git
cd ~

# Zsh History Substring Search
cd ~/Zsh/Plugins
git clone https://github.com/zsh-users/zsh-history-substring-search.git
cd ~

# Nordzy Cursors
cd ~/Github
git clone https://github.com/alvatip/Nordzy-cursors.git
cd Nordzy-cursors
./install.sh

# Papirus Icon Theme
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

# Nordic Theme
cd ~/.themes
git clone https://github.com/EliverLara/Nordic.git

# Rofi Power Menu
cd ~/Github
git clone https://github.com/jluttine/rofi-power-menu.git
cd rofi-power-menu
cp rofi-power-menu ~/.local/bin/
cd ~

# Greenclip
cd ~/.local/bin
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
chmod a+x greenclip 
cd ~

# Nitch
wget https://raw.githubusercontent.com/unxsh/nitch/main/setup.sh
chmod a+x setup.sh
./setup.sh
rm setup.sh

# Getting the flathub repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
