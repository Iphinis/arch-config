#!/bin/bash

echo "[iphinis' config automated installation]"

CURPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PKGCONF=$CURPATH/.config/packages

echo "[copying config to home directory...]"
cat $PKGCONF/files.txt | xargs -I FILE cp $CURPATH/FILE ~/ --verbose --update

mkdir -p ~/.config
mkdir -p ~/images/screenshots
cp $CURPATH/.config/* ~/.config/ --verbose --update -R

# zsh installation
if ! pacman -Qs "zsh" > /dev/null; then
	echo "[zsh installation]"
	sudo pacman -S --needed zsh zsh-completions
fi
zshpath="/usr/bin/zsh"
if [[ $SHELL != $zshpath ]]; then
	echo "[changing shell to zsh]"
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
echo "[core-packages installation]"
sudo pacman -S --needed - < $PKGCONF/core-packages.txt
echo "[utility-packages installation]"
sudo pacman -S --needed - < $PKGCONF/utility-packages.txt
echo "[browser-packages installation]"
sudo pacman -S --needed - < $PKGCONF/browser-packages.txt
echo "[fonts installation]"
sudo pacman -S --needed - < $PKGCONF/fonts.txt

# yay packages
echo "[aur-packages installation]"
yay -S --needed - < $PKGCONF/aur-packages.txt

# systemd services
echo "[systemd services activation]"
BTRLCK=betterlockscreen@$(logname).service
if [[ $(systemctl is-enabled $BTRLCK) != "enabled" ]]; then
	echo $BTRLCK
	systemctl enable $BTRLCK
fi
