#!/bin/env bash

# Checking if script is run with root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

echo "#########################"
echo "## Updating The System ##"
echo "#########################"
pacman -Syu

echo "#######################"
echo "## CLI Nice To Haves ##"
echo "#######################"
pacman -S direnv yad fzf locate gh tree build-essential git \
  cmake make hidapi-devel gpg openssl tldr dnf-plugins-core lsd \
  trash-cli g++ gcc wget curl python3 unzip tar python3-setuptools \
  autojump autojump-zsh luarocks ranger shellcheck python3-pylint-venv \
  meson stow qalculate libtool ninja-build python3-pytest-venv \
  autoconf automake lazygit --noconfirm

echo "##################"
echo "## Wifi Manager ##"
echo "##################"
pacman -S NetworkManager --noconfirm

echo "##################"
echo "## Text Editors ##"
echo "##################"
pacman -S ripgrep fd-find neovim --noconfirm

echo "##################"
echo "## Pkg Managers ##"
echo "##################"
pacman -S npm flatpak golang cargo python3-pip --noconfirm

echo "###############"
echo "## XDG Stuff ##"
echo "###############"
pacman -S xdg-user-dirs xdg-user-dirs-gtk --noconfirm

echo "###############"
echo "## Fun Stuff ##"
echo "###############"
pacman -S neofetch cowsay cmatrix lolcat --noconfirm

echo "###############"
echo "## USB Utils ##"
echo "###############"
pacman -S udiskie udisks2 --noconfirm

echo "######################"
echo "## Resource Monitor ##"
echo "######################"
pacman -S btop htop bashtop --noconfirm

echo "############################"
echo "## Installing Shell Stuff ##"
echo "############################"
pacman -S zsh zsh-syntax-highlighting bash-completion --noconfirm

echo "#####################"
echo "## Installing Java ##"
echo "#####################"
pacman -S jdk17-openjdk jdk11-openjdk jdk8-openjdk --noconfirm
pacman -S jre17-openjdk jre11-openjdk jre8-openjdk --noconfirm

echo "#############################"
echo "## Installing GUI Programs ##"
echo "#############################"
pacman -S polybar galculator kitty bleachbit timeshift \
  transmission-gtk dconf-editor sxhkd arandr xterm \
  xclip xbacklight xsel xdotool screenkey --noconfirm

echo "############################"
echo "## Installing Rofi Stufff ##"
echo "############################"
pacman -S rofi-emoji rofi-calc --noconfirm

echo "############################"
echo "## Installing Media Stuff ##"
echo "############################"
pacman -S rhythmbox playerctl pavucontrol yt-dlp mpv peek sxiv --noconfirm

echo "############################"
echo "## Installing Theme Stuff ##"
echo "############################"
pacman -S qt5ct qt5-style-plugins lxappearance --noconfirm

echo "###########################"
echo "## Installing File Stuff ##"
echo "###########################"
pacman -S gvfs thunar-archive-plugin thunar file-roller --noconfirm

echo "##################################"
echo "## Installing Things For Any WM ##"
echo "##################################"
pacman -S xwallpaper flameshot lxpolkit rofi i3lock --noconfirm

echo "#################################"
echo "## Installing Things For Picom ##"
echo "#################################"
pacman -S libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev \
  libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev \
  libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev \
  libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev \
  libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev \
  libevdev-dev uthash-dev libev-dev libx11-xcb-dev --noconfirm

echo "################################"
echo "## Installing Window Managers ##"
echo "################################"
pacman -S awesome --noconfirm 

echo "#############################"
echo "## Installing Office Stuff ##"
echo "#############################"
pacman -S libreoffice zathura --noconfirm

echo "########################"
echo "## Installing Drivers ##"
echo "########################"
pacman -S mesa-utils --noconfirm

# Script Variables
username=$(id -u -n 1000)
builddir=$(pwd)

echo "######################"
echo "## Installing Fonts ##"
echo "######################"
pacman -S otf-font-awesome fontconfig ttf-ubuntu-font-family \
  noto-fonts noto-fonts-cjk	ttf-font-awesome noto-fonts-emoji \
  noto-fonts-extra --noconfirm

echo "####################"
echo "## Installing UFW ##"
echo "####################"
pacman -S ufw --noconfirm
sleep 2.5
ufw limit 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw default deny incoming
ufw default allow outgoing
ufw enable
systemctl enable ufw

echo "#############"
echo "## Pfetch  ##"
echo "#############"
wget https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch
chmod a+x pfetch
mv -v pfetch /usr/bin/

echo "#####################"
echo "## Starship Prompt ##"
echo "#####################"
curl -sS https://starship.rs/install.sh | sh
