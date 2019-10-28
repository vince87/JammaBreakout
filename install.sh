#!/bin/bash
########################################################
## Vincenzo Bini 20/09/2018
## Versione 0.5
#########################################################

dialog --title "Script installazione Jamma Breakout" --msgbox "Attenzione verranno ora installati i driver per il corretto funzionamento della Jamma Breakout.
\n \nSe stai usando un immagine custom, non scaricata da retropie.org.uk, accertati di aver disattivato tutti gli script che usano i GPIO." 12 60

cd ~
sudo apt-get update
sudo apt-get install -y git dialog
git clone https://github.com/vince87/JammaBreakout.git
cd ~/JammaBreakout
git pull
chmod +x install.sh


  ##Modify Config.txt to Default
	printf "\033[1;31m Modifico il config.txt per la JammaBreakout \033[0m\n"
	sudo grep 'Pi 4' /proc/device-tree/model > /dev/null 2>&1 
		if [ $? -eq 0 ] ; then
        	sudo sh -c "echo 'dtoverlay=audremap,pins_18_19' >> /boot/config.txt"
		else
		sudo sh -c "echo 'dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2' >> /boot/config.txt"
		fi
	sudo sh -c "echo 'audio_pwm_mode=3' >> /boot/config.txt"
	sudo sh -c "echo 'disable_audio_dither=1' >> /boot/config.txt"
	amixer cset numid=3 "1"
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
	sudo sh -c "echo 'mk_arcade_joystick_rpi' >> /etc/modules"
	echo "Modulo impostato!"
	fi
	sleep 2
	
##install jammapi menu script
	printf "\033[1;31m Installo menu x RetroPie \033[0m\n"
	rm ~/RetroPie/retropiemenu/Abilita-Disabilita-Breakout.sh
	cp -r ~/JammaBreakout/script/Abilita-Disabilita-Breakout.sh ~/RetroPie/retropiemenu
	sleep 2
  
    
    		printf "\033[0;32m !!!INSTALLAZIONE COMPLETATA!!! \033[0m\n"
  
#reboot				
