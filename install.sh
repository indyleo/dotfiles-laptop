#!/bin/env bash

# Checking if script is run with root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

echo "##############################"
echo "## Making 'dnf.conf' Better ##"
echo "##############################"
rm -v /etc/dnf/dnf.conf
mv -v dnf.conf /etc/dnf/dnf.conf

echo "#########################"
echo "## Updating The System ##"
echo "#########################"
dnf update
dnf upgrade -y

echo "#######################"
echo "## Adding RPM Fusion ##"
echo "#######################"
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf groupupdate core -y

echo "#######################"
echo "## CLI Nice To Haves ##"
echo "#######################"
dnf install direnv yad fzf locate gh tree build-essential git \
  cmake make hidapi-devel gpg openssl tldr dnf-plugins-core lsd \
  trash-cli g++ gcc wget curl python3 unzip tar python3-setuptools \
  autojump autojump-zsh luarocks ranger shellcheck python3-pylint-venv \
  meson stow qalculate libtool ninja-build python3-pytest-venv \
  autoconf automake -y

echo "##################"
echo "## Wifi Manager ##"
echo "##################"
dnf install NetworkManager -y

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
dnf install neofetch cowsay cmatrix lolcat -y

echo "###############"
echo "## USB Utils ##"
echo "###############"
dnf install udiskie udisks2 -y

echo "######################"
echo "## Resource Monitor ##"
echo "######################"
dnf install btop htop -y

echo "############################"
echo "## Installing Shell Stuff ##"
echo "############################"
dnf install zsh zsh-syntax-highlighting bash-completion -y

echo "#####################"
echo "## Installing Java ##"
echo "#####################"
dnf install java-11-openjdk java-17-openjdk java-1.8.0-openjdk -y

echo "#############################"
echo "## Installing GUI Programs ##"
echo "#############################"
dnf install polybar galculator kitty bleachbit timeshift \
  transmission-gtk dconf-editor sxhkd arandr xterm \
  xclip xbacklight xsel xdotool screenkey -y

echo "###############################"
echo "## Installing Xorg-X11 Stuff ##"
echo "###############################"
dnf install xorg-x11-server-Xorg xorg-x11-xinit xorg-x11-xauth abrt-addon-xorg \
  xorg-x11-resutils xorg-x11-drivers xorg-x11-font-utils xrandr -y

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
dnf copr enable linuxredneck/xwallpaper -y
dnf install xwallpaper flameshot lxpolkit rofi i3lock -y

echo "#################################"
echo "## Installing Things For Picom ##"
echo "#################################"
dnf install dbus-devel libconfig-devel libdrm-devel libev-devel libX11-devel libX11-xcb libXext-devel \
  libxcb-devel libGL-devel libEGL-devel pcre2-devel pixman-devel uthash-devel xcb-util-image-devel \
  xcb-util-renderutil-devel xorg-x11-proto-devel -y

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
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install brave-browser -y

echo "########################"
echo "## Installing Drivers ##"
echo "########################"
dnf install mesa-utils -y

# Script Variables
username=$(id -u -n 1000)
builddir=$(pwd)

echo "######################"
echo "## Installing Fonts ##"
echo "######################"
dnf copr enable atim/ubuntu-fonts -y
dnf install fontawesome-fonts fontconfig ubuntu-family-fonts -y
dnf install google-noto-cjk-fonts google-noto-emoji-fonts google-noto-fonts-common google-noto-sans-cjk-fonts google-noto-sans-hk-fonts \
  google-noto-serif-cjk-fonts google-noto-sans-cjk-vf-fonts google-noto-serif-cjk-vf-fonts-y

echo "####################"
echo "## Installing UFW ##"
echo "####################"
dnf install ufw -y
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
