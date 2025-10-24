#!/bin/bash
echo "starting installation process for aor-rex i3-dotfiles' dependencies..."
#updating system packages 
sudo pacman -Syu --noconfirm

#core dependencies
sudo pacman -S --noconfirm i3-wm i3-gaps i3status i3lock polybar rofi kitty feh brightnessctl pactl network-manager-applet playerctl dex scrot xorg-xrandr

#AUR dependencies
if ! command -v yay &> /dev/null
then
    echo "yay could not be found, installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd .. || exit
    rm -rf yay
fi

yay -S --noconfirm superfile picom-fitlabs-git

#optional installs
read -p "install brave Browser? (y/n): " brave
if [[ $brave == "y" || $brave == "Y" ]]; then
    yay -S --noconfirm brave-bin
fi

read -p "install vs code? (y/n): " code
if [[ $code == "y" || $code == "Y" ]]; then
    yay -S --noconfirm visual-studio-code-bin
fi


echo "dependencies installed successfully!"