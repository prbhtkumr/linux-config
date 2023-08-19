#!/bin/bash

## Install Basic Tools
echo "Installing Basic Tools..."
sudo pacman -Syyu
sudo pacman -S base-devel git neovim fzf
echo "Done ✅"

## Install Paru
echo "Installing Paru..."
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf ./paru/
echo "Done ✅"

## Install Other Applications
echo "Installing Other Applications"
paru -S paruz bat bat-extras unzip ufw jq starship zsh reflector ntfs-3g
echo "Done ✅"
