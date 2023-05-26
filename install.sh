#!/bin/env bash

# Checking if script is run with root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

echo "#########################"
echo "## Updating The System ##"
echo "#########################"
dnf update
dnf upgrade -y

echo "#######################"
echo "## Adding RPM Fusion ##"
echo "#######################"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core

echo "#######################"
echo "## CLI Nice To Haves ##"
echo "#######################"
dnf install direnv yad fzf locate gh tree build-essential git \
  cmake make libhidapi-dev gpg openssl tldr \
  trash-cli g++ gcc wget curl python3 unzip tar python3-setuptools \
  autojump luarocks ranger shellcheck python3-venv meson \
  stow apt-transport-https qalc cmdtest qalc libtool ninja-build \
  dnf-plugins-core lsd -y

echo "##################"
echo "## Wifi Manager ##"
echo "##################"
dnf install network-manager -y

echo "##################"
echo "## Text Editors ##"
echo "##################"
dnf install ripgrep fd-find neovim -y

echo "##################"
echo "## Pkg Managers ##"
echo "##################"
dnf install npm flatpak golang cargo python3-pip -y

echo "###############"
echo "## XDG Stuff ##"
echo "###############"
dnf install xdg-user-dirs xdg-user-dirs-gtk -y

echo "###############"
echo "## Fun Stuff ##"
echo "###############"
dnf install neofetch cowsay cmatrix tty-clock lolcat -y

echo "###############"
echo "## USB Utils ##"
echo "###############"
dnf install udiskie udisks2 -y

echo "######################"
echo "## Resource Monitor ##"
echo "######################"
dnf install btop htop bashtop -y

echo "############################"
echo "## Installing Shell Stuff ##"
echo "############################"
dnf install zsh zsh-syntax-highlighting bash-completion -y

echo "#####################"
echo "## Installing Java ##"
echo "#####################"
dnf install openjdk-11-jdk openjdk-11-jre openjdk-17-jdk openjdk-17-jre openjdk-8-jdk openjdk-8-jre -y

echo "#############################"
echo "## Installing GUI Programs ##"
echo "#############################"
dnf install polybar galculator kitty bleachbit timeshift \
  transmission-gtk dconf-editor xinit sxhkd arandr xterm \
  xclip rofi-dev xbacklight xsel xdotool screenkey -y

echo "############################"
echo "## Installing Media Stuff ##"
echo "############################"
dnf install rhythmbox playerctl pavucontrol yt-dlp mpv peek sxiv -y

echo "############################"
echo "## Installing Theme Stuff ##"
echo "############################"
dnf install qt5ct qt5-style-plugins lxappearance -y

echo "###########################"
echo "## Installing File Stuff ##"
echo "###########################"
dnf install gvfs thunar-archive-plugin thunar file-roller -y

echo "##################################"
echo "## Installing Things For Any WM ##"
echo "##################################"
dnf install xwallpaper flameshot lxpolkit rofi i3lock-fancy -y

echo "#################################"
echo "## Installing Things For Picom ##"
echo "#################################"
ndnf install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev \
  libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev \
  libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev \
  libev-dev libx11-xcb-dev -y 

echo "################################"
echo "## Installing Window Managers ##"
echo "################################"
dnf install awesome -y 

echo "#############################"
echo "## Installing Office Stuff ##"
echo "#############################"
dnf install libreoffice zathura -y

echo "##########################"
echo "## Installing A Browser ##"
echo "##########################"
dnf remove firefox -y
dnf install 
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install brave-browser -y

echo "########################"
echo "## Installing Drivers ##"
echo "########################"
nala install mesa-utils -y

# Script Variables
username=$(id -u -n 1000)
builddir=$(pwd)

echo "######################"
echo "## Installing Fonts ##"
echo "######################"
nala install fonts-font-awesome fontconfig fonts-noto -y

echo "###########################"
echo "## Installing Nerd Fonts ##"
echo "###########################"
mkdir -pv /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/FiraCode.zip
unzip -n FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Ubuntu.zip
unzip -n Ubuntu.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/UbuntuMono.zip
unzip -n UbuntuMono.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/CascadiaCode.zip
unzip -n CascadiaCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/NerdFontsSymbolsOnly.zip
unzip -n NerdFontsSymbolsOnly.zip -d /home/$username/.fonts
chown $username:$username /home/$username/.fonts/
chown $username:$username /home/$username/.fonts/*

echo "##########################"
echo "## Reloading Font Cache ##"
echo "##########################"
fc-cache -vf

echo "###################################"
echo "## Removing Zip Files From Fonts ##"
echo "###################################"
rm -v ./FiraCode.zip ./Ubuntu.zip ./UbuntuMono.zip ./CascadiaCode.zip ./NerdFontsSymbolsOnly.zip

echo "####################"
echo "## Installing UFW ##"
echo "####################"
nala install ufw -y
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
