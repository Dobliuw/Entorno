#!/bin/bash 

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
	echo -e "\n${redColour}[!]${endColour} ${grayColour}Quiting...${endColour}\n"
  	exit 1
}

trap ctrl_c INT

function help_panel(){
	echo -e "\n${redColour}[!] El script debe ejecutarse de la sig manera: ${endColour}\n ${grayColour}./$0 NOMBRE_DE_USUARIO${endColour}\n"
    exit 1
}

function configAll(){
	if [[ $EUID -ne 0 ]]; then
		echo -e "\n\n\t${redColour}Necesita ejecutarse como sudo ツ${endColour}\n\n"
		ctrl_c
	elif [[ ! "$1" ]]; then
		help_panel
	else
		initial_path=$(pwd)
		echo -e "\n\n\t${purpleColour}[!]${endColour} Instalando paquetes necesarios...${grayColour}${endColour}\n\n"
		sudo apt install imagemagick kitty rofi bat build-essential git vim xcb zsh libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev cmake cmake-data pkg-config libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libuv1-dev libnl-genl-3-dev feh meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev -Y 1>/dev/null 
		echo -e "\n\n\t${purpleColour}[!]${endColour} Realizando configuraciones del sistema...${grayColour}${endColour}\n\n"
		mkdir -p /home/$1/.local/bin
		ln -s /usr/bin/batcat /home/$1/.local/bin/bat
		mkdir /home/$1/.config/bspwm && cp -r ./configs/bspwm/* /home/$1/.config/bspwm
		mkdir /home/$1/.config/sxhkd && cp -r ./configs/sxhkd/* /home/$1/.config/sxhkd
		mkdir /home/$1/.config/picom && cp -r ./configs/picom/* /home/$1/.config/picom
		mkdir /home/$1/.config/polybar && cp -r ./configs/polybar/* /home/$1/.config/picom
		mkdir /home/$1/.config/kitty && cp -r ./configs/kitty/* /home/$1/.config/kitty
		mkdir /home/$1/.config/bin && cp -r ./configs/bin/* /home/$1/.config/bin
		cp -r ./configs/fonts/* /usr/local/share/fonts
		workspace=$(mktemp)
		cd $workspace
		wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd-musl_0.23.1_amd64.deb
		sudo dpkg -i lsd-musl_0.23.1_amd64.deb
		git clone https://github.com/baskerville/bspwm.git &>/dev/null
		git clone https://github.com/baskerville/sxhkd.git &>/dev/null
		git clone --recursive https://github.com/polybar/polybar &>/dev/null
		git clone https://github.com/ibhagwan/picom.git
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$1/powerlevel10k
		cd bspwm && make && sudo make install &>/dev/null
		sudo apt install bspwm
		cd sxhkd && make && sudo make install &>/dev/null
		cd polybar && mkdir build && cd build && cmake .. && make -j$(nproc) && sudo make install &>/dev/null
		cd picom && git submodule update --init --recursive && meson setup --buildtype=release . build && ninja -C build && sudo ninja -C build install &>/dev/null
		echo -e "\n\n\t${purpleColour}[!]${endColour} Configurando la consola de root...${grayColour}${endColour}\n\n"
		chmod +x /home/$1/.config/polybar/config && chmod +x /home/$1/.config/polybar/launch.sh
		sudo usermod --shell /usr/bin/zsh root && sudo chown root:root /usr/local/share/zsh/site-functions/_bspc && sudo ln -s -f /home/$1/.zshrc /root/.zshrc 
		sudo rm -rf $workspace
		echo -e "[!] /home/$1/nashe"
		cd $initial_path
		echo -e "\n\n\t${purpleColour}[!]${endColour} Configuración finalizada, que lo disfrutes.${grayColour}${endColour}\n\n"
		echo -e "${grayColour}Quieres salir a la página de seleccion para ver tu nuevo entorno? y/n"
		read seeEnviroment
		if [[ $seeEnviroment == "y" ]]; then
			sudo kill -9 -1
		else
			exit 0
		fi
	fi
}

