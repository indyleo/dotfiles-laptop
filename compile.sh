#!/bin/env bash

# Script Variables
builddir=$(pwd)

echo "########################################"
echo "## Adding Some Directories, And Files ##"
echo "########################################"
mkdir -pv ~/Github ~/Img ~/Applications ~/Zsh/Plugins ~/Pictures/Screenshots ~/Scripts ~/.icons ~/.themes ~/.cache/zsh ~/.local/bin ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Videos
touch ~/.cache/zsh/history 

echo "#################################"
echo "## Installing AUR Helper (YAY) ##"
echo "#################################"
cd ~/Github
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

echo "#################################"
echo "## Installing Some AUR Pakages ##"
echo "#################################" 
yay -S shell-color-scripts brave-bin moar rofi-greenclip gotop tty-clock --noconfirm

echo "######################"
echo "## Picom Animations ##"
echo "######################"
cd ~/Github
git clone https://github.com/FT-Labs/picom.git
cd picom
git submodule update --init --recursive
meson setup --buildtype=release . build
ninja -C build
sudo ninja -C build install
cd ~

echo "###########################"
echo "## Installing Nerd Fonts ##"
echo "###########################"
mkdir -pv ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/FiraCode.zip
unzip -n FiraCode.zip -d ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Ubuntu.zip
unzip -n Ubuntu.zip -d ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/UbuntuMono.zip
unzip -n UbuntuMono.zip -d ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/CascadiaCode.zip
unzip -n CascadiaCode.zip -d ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/NerdFontsSymbolsOnly.zip
unzip -n NerdFontsSymbolsOnly.zip -d ~/.fonts

echo "##########################"
echo "## Reloading Font Cache ##"
echo "##########################"
fc-cache -vf

echo "###################################"
echo "## Removing Zip Files From Fonts ##"
echo "###################################"
rm -v ./FiraCode.zip ./Ubuntu.zip ./UbuntuMono.zip ./CascadiaCode.zip ./NerdFontsSymbolsOnly.zip

echo "########################################"
echo "## Moving, Deleting, And Adding Files ##"
echo "########################################" 
mkdir -v ~/.config
cd $builddir
git clone https://github.com/indyleo/Wallpapers.git ~/Pictures/Wallpapers/
mv -v sxhkd polybar neofetch nvim ranger picom awesome conky kitty rofi starship.toml mimeapps.list user-dirs.dirs greenclip.toml ~/.config/
rm -v ~/.bashrc ~/.profile ~/.zshenv
mv -v .bashrc .zshrc .zshenv .aliasrc .xsession .profile .xinitrc .Xresources ~/
mv -v $builddir/scripts/* ~/.local/bin/

echo "#################"
echo "## Zsh Plugins ##"
echo "#################" 
cd ~/Zsh/Plugins
git clone https://github.com/hlissner/zsh-autopair.git
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git
cd ~

echo "###################"
echo "## Cursors Theme ##"
echo "###################" 
cd ~/Github
git clone https://github.com/alvatip/Nordzy-cursors.git
cd Nordzy-cursors
./install.sh

echo "#################"
echo "## Icons Theme ##"
echo "#################" 
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

echo "###############"
echo "## GTK Theme ##"
echo "###############" 
cd ~/.themes
git clone https://github.com/EliverLara/Nordic.git

echo "##################"
echo "## Flatpak Repo ##"
echo "##################"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
