#!/bin/bash
sudo grep '#mk_arcade_joystick_rpi' /etc/modules > /dev/null 2>&1
if [ $? -eq 0 ] ; then

echo "La breakout non è attiva!"
sleep 4
echo "Attivo la breakout!"

sudo perl -p -i -e 's/#mk_arcade_joystick_rpi/mk_arcade_joystick_rpi/g' /etc/modules

sudo perl -p -i -e 's/#dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2/dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2/g' /boot/config.txt
sudo perl -p -i -e 's/#disable_audio_dither=1/disable_audio_dither=1/g' /boot/config.txt


sudo modprobe mk_arcade_joystick_rpi map=1,2

echo "Modifiche effettuate!"

else

echo "La breakout è attiva!"
sleep 4
echo "Disattivo la breakout!"

sudo perl -p -i -e 's/mk_arcade_joystick_rpi/#mk_arcade_joystick_rpi/g' /etc/modules

sudo perl -p -i -e 's/dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2/#dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2/g' /boot/config.txt
sudo perl -p -i -e 's/disable_audio_dither=1/#disable_audio_dither=1/g' /boot/config.txt


sudo modprobe -r mk_arcade_joystick_rpi

echo "Modifiche effettuate!"

fi

sleep 5
