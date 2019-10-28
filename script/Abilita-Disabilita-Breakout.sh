#!/bin/bash

HEIGHT=10
WIDTH=60
BACKTITLE="Jamma Breakout Menù"
TITLE="Abilita/Disabilita Jamma Breakout"
MENU="Scegliere un opzione:"

OPTIONS=(1 "Abilita Jamma Breakout"
         2 "Disabilita Jamma Breakout")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
        echo "Attivo la breakout!"
        sudo perl -p -i -e 's/#mk_arcade_joystick_rpi/mk_arcade_joystick_rpi/g' /etc/modules
        sudo perl -p -i -e 's/#dtoverlay=audremap,pins_18_19/dtoverlay=audremap,pins_18_19/g' /boot/config.txt
        sudo perl -p -i -e 's/#dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2/dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2/g' /boot/config.txt
        sudo perl -p -i -e 's/#disable_audio_dither=1/disable_audio_dither=1/g' /boot/config.txt
        sudo modprobe mk_arcade_joystick_rpi map=1,2
        echo "Modifiche effettuate!"
        ;;
        2)
        echo "Disattivo la breakout!"
        sudo perl -p -i -e 's/mk_arcade_joystick_rpi/#mk_arcade_joystick_rpi/g' /etc/modules
        sudo perl -p -i -e 's/dtoverlay=audremap,pins_18_19/#dtoverlay=audremap,pins_18_19/g' /boot/config.txt
        sudo perl -p -i -e 's/dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2/#dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2/g' /boot/config.txt
        sudo perl -p -i -e 's/disable_audio_dither=1/#disable_audio_dither=1/g' /boot/config.txt
        sudo modprobe -r mk_arcade_joystick_rpi
        echo "Modifiche effettuate!"
        ;;
esac
sleep 5
