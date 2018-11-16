#!/bin/bash
########################################################
## Vincenzo Bini 20/09/2018
## Versione 0.5
#########################################################

cd ~
sudo apt-get install -y git
git clone https://github.com/vince87/JammaBreakout.git
cd ~/JammaBreakout
git pull
chmod +x install.sh


  ##Modify Config.txt to Default
	printf "\033[1;31m Modifico il config.txt per la JammaBreakout \033[0m\n"
	sudo grep 'dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2' /boot/config.txt > /dev/null 2>&1
	if [ $? -eq 0 ] ; then
	echo "Config.txt già modificato!"
	else
	sudo sh -c "echo '#dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2' >> /boot/config.txt"
	echo "Config.txt modificato!"
	fi
	sleep 2

##install jammapi joystick driver
	printf "\033[1;31m Installo driver Joystick \033[0m\n"
	cd ~/JammaBreakout/mk_arcade_joystick/
	sudo mkdir /usr/src/mk_arcade_joystick_rpi-0.1.5/
	sudo cp -a * /usr/src/mk_arcade_joystick_rpi-0.1.5/
	cd ~/JammaBreakout
	sudo dkms build -m mk_arcade_joystick_rpi -v 0.1.5
	sudo dkms install -m mk_arcade_joystick_rpi -v 0.1.5
	sudo modprobe mk_arcade_joystick_rpi map=1,2
	sudo rm /etc/modprobe.d/mk_arcade_joystick.conf
	echo "options mk_arcade_joystick_rpi map=1,2" >> mk_arcade_joystick.conf
	sudo mv mk_arcade_joystick.conf /etc/modprobe.d/
	sudo grep 'mk_arcade_joystick_rpi' /etc/modules > /dev/null 2>&1
	if [ $? -eq 0 ] ; then
	echo "Già modificato!"
	else
	sudo sh -c "echo '#mk_arcade_joystick_rpi' >> /etc/modules"
	echo "Modulo impostato!"
	fi
	sleep 2
	
##install jammapi menu script
	printf "\033[1;31m Installo menu x RetroPie \033[0m\n"
	rm ~/RetroPie/retropiemenu/Abilita-Disabilita Breakout.sh
	cp -r ~/JammaBreakout/script/Abilita-Disabilita Breakout.sh ~/RetroPie/retropiemenu
	sleep 2
  
    
    		printf "\033[0;32m !!!INSTALLAZIONE COMPLETATA!!! \033[0m\n"
  
#reboot				
