#!/bin/bash
echo "starting installation process for aor-rex i3-dotfiles' dependencies..."
#updating system packages 
sudo apt update && sudo apt upgrade -y

#core dependencies
sudo apt install -y i3 i3status i3lock polybar rofi kitty feh brightnessctl pulseaudio-utils pactl network-manager-applet playerctl dex scrot xorg-xrandr

# installing superfile
echo "installing superfile..."
bash -c "$(curl -sLo- https://superfile.dev/install.sh)"
echo "superfile installed successfully!"


#picom installation
echo "installing picom..."
sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev

git clone https://github.com/ibhagwan/picom.git
cd picom
meson setup --buildtype=release build
ninja -C build
ninja -C build install

echo "picom installed successfully!"
cd .. || exit


#optional installs
read -p "install brave browser? (y/n): " brave
if [[ $brave == "y" || $brave == "Y" ]]; then
    sudo apt-install -y curl
    curl -fsS https://dl.brave.com/install.sh | sh
fi

read -p "install vs code? (y/n): " code
if [[ $code == "y" || $code == "Y" ]]; then
    sudo apt install software-properties-common apt-transport-https
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode/ stable main" > /etc/apt/sources.list.d/vscode.list'
    snap install code
fi


echo "dependencies installed successfully!"

#installing configuration files
echo "installing configuration files..."

cp -r .config/* ~/.config/
cp -r Pictures/* ~/Pictures/

echo "configuration files installed successfully!"

echo "installation process completed! restart and log into i3-wm sessions"