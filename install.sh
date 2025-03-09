#!/bin/bash

echo "Iphinis' dotfiles automated installation"

CURPATH=$(dirname "$(realpath "$0")")
PKGCONF=$CURPATH/.config/packages

echo "Copying config files to home directory..."
cat $PKGCONF/files.txt | xargs -I FILE cp $CURPATH/FILE ~/ --verbose --update

mkdir -p ~/.config
cp $CURPATH/.config/* ~/.config/ --verbose --update -R

# zsh installation
if ! pacman -Qs "zsh" > /dev/null; then
	sudo pacman -S --needed zsh zsh-completions
fi
zshpath="/usr/bin/zsh"
if [[ $SHELL != $zshpath ]]; then
	chsh -s $zshpath
fi

# yay installation
if ! pacman -Qs "yay" > /dev/null; then
	echo "[yay installation]"
	sudo pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	sudo -u $(logname) makepkg -si
	cd ..
	rm -rf yay
fi

# pacman packages
sudo pacman -S --needed - < $PKGCONF/core-packages.txt
sudo pacman -S --needed - < $PKGCONF/utility-packages.txt
sudo pacman -S --needed - < $PKGCONF/browser-packages.txt
sudo pacman -S --needed - < $PKGCONF/fonts.txt

# yay packages
yay -S --needed - < $PKGCONF/aur-packages.txt
