#!/bin/bash

(set +x; echo -e "\n[iphinis' config automated installation]")

# enable shell debugging
set -x

source script-env.sh

CURPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PKGCONF=$CURPATH/.config/packages

(set +x; echo -e "\n[copying config to home directory...]")
cat $PKGCONF/files.txt | xargs -I FILE cp $CURPATH/FILE ~/ --verbose --update

mkdir -p ~/.config
mkdir -p $(xdg-user-dir PICTURES)/Screenshots
cp $CURPATH/.config/* ~/.config/ --verbose --update -R

# keyboard layout
localectl set-x11-keymap --no-convert us "" altgr-intl

# zsh installation
if ! pacman -Qs "zsh" > /dev/null; then
(set +x; echo -e "\n[zsh installation]")
	sudo pacman -S --needed zsh zsh-completions
fi
zshpath="/usr/bin/zsh"
if [[ $SHELL != $zshpath ]]; then
(set +x; echo -e "\n[changing shell to zsh]")
	chsh -s $zshpath
fi

# yay installation
if ! pacman -Qs "yay" > /dev/null; then
(set +x; echo -e "\n[yay installation]")
	sudo pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	sudo -u $(logname) makepkg -si
	cd ..
	rm -rf yay
fi

# pacman
(set +x; echo -e "\n[core-packages installation]")
sudo pacman -S --needed - < $PKGCONF/core-packages.txt
(set +x; echo -e "\n[utility-packages installation]")
sudo pacman -S --needed - < $PKGCONF/utility-packages.txt
(set +x; echo -e "\n[browser-packages installation]")
sudo pacman -S --needed - < $PKGCONF/browser-packages.txt
(set +x; echo -e "\n[fonts installation]")
sudo pacman -S --needed - < $PKGCONF/fonts.txt

if [[ -r $PKGCONF/personal-arch.txt ]]; then
	(set +x; echo -e "\n[personal arch installation]")
	sudo pacman -S --needed - < $PKGCONF/personal-arch.txt
fi

# yay
(set +x; echo -e "\n[aur-packages installation]")
yay -S --needed - < $PKGCONF/aur-packages.txt

if [[ -r $PKGCONF/personal-aur.txt ]]; then
	(set +x; echo -e "\n[personal yay installation]")
	sudo pacman -S --needed - < $PKGCONF/personal-aur.txt
fi

# systemd services
(set +x; echo -e "\n[systemd services activation]")
chmod +x ./services.sh
./services.sh
