#!/usr/bin/env bash
clear
t=`tput setaf 4`
i=`tput setaf 1`
e="$(tput sgr0)\n"
printf "${t}LordNature's .files${e}"

cd $HOME
uid=`id -u`
if [[ $uid == 0 ]]; then
	echo "${i}Woah! You forgot that you were root!"
	exit 1
fi

printf "Time to cook!\n"
printf "This won't install graphics btw.\n"
for sec in {10..0}; do
	sleep 1
	printf "${i}We are cooking in $sec seconds...${e}"
done
printf "\n"

dir=`pwd`
mkdir -p $HOME/temp

printf "All your passwords belong to us.\n"
sudo printf "You fool! Ha! I've got your password now.\n"

printf "${t}Preperation: Let's fetch those updates!${e}"
sudo xbps-install -Syu

printf "${t}Ingredients: Time to add the applications...${e}"
sudo xbps-install -y i3-gaps dmenu polybar firefox htop git automake autoconf make ffmpeg unzip unclutter feh compton R vim

printf "${t}Spices: Install st terminal...${e}"
sudo xbps-remove -Ry st
sudo xbps-install -y gcc libXft-devel fontconfig-devel pkg-config
cd $HOME/temp
git clone https://github.com/LukeSmithXYZ/st.git
cd st
make
sudo make install

printf "${t}Spices: Install Discord...${e}"
sudo xbps-install xtools
git clone https://github.com/voidlinux/void-packages
cd void-packages
./xbps-src binary-bootstrap
./xbps-src pkg discord
sudo xi -y discord

printf "${t}Decorations: Getting your favorite eye candy ready...${e}"
sudo xbps-remove -y xorg-fonts
sudo xbps-install -y tewi-font google-fonts-ttf freefont-ttf

printf "${t}Decorations: Symlinking the links of links O_O...${e}"
ln -si $dir/.Xresources $HOME/.Xresources
ln -si $dir/.zshrc $HOME/.zshrc
ln -si $dir/i3 $HOME/.config/i3
ln -si $dir/.fehbg $HOME/.fehbg
ln -si $dir/bin $HOME/bin
# Disabled for now because I change it a lot.
# ln -si $dir/wall.jpg $HOME/.config/wall.jpg

printf "${t}Wrap it all together and make it clean...${e}"
sudo xbps-remove -oy
rm -rf $HOME/temp

printf "${i}Ding ding! It's complete!${e}"
sleep 3
