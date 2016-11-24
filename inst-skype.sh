#!/bin/bash

echo " Turysaz' skype download and installation script for Ubuntu"
echo " This is free software and comes with ABSOLUTELY NO WARRANTY!"
echo
echo
echo " User password required for some necessary actions "

read -s -p " Please enter password [will not be displayed]" pw

sudo -k #reset login
pw_check=wrong
pw_check=$(echo $pw | sudo -S -p "" -- echo correct)
if [[ $pw_check != correct ]]
then
    echo " wrong password. abort."
    unset pw
    exit -1
fi

echo " thank you."
echo " starting now."
sleep 1

cd ~/Downloads/

echo && echo ======== DOWNLOADING INSTALLER ========= && echo && sleep 2

wget -O skype-installer.deb https://download.skype.com/linux/skype-ubuntu-precise_4.3.0.37-1_i386.deb

echo && echo ======== UNPACKING SKYPE =========== && echo && sleep 2

#echo $pw | sudo -s -p "reading password..." -- echo would install
echo $pw | sudo -s -p "reading password..." -- dpkg --install skype-installer.deb

echo && echo ======== FIXING KNOWN ISSUES ======= && echo && sleep 2

echo $pw | sudo -s -p "reading password..." -- apt-get -q --yes -f install

echo && echo == CHECKING FOR ORPHAN PACKAGES, JUST IN CASE... == && echo && sleep 2

echo $pw | sudo -s -p "reading password..." -- apt-get -q --yes autoremove

echo && echo =============== REMOVING INSTALLER ================== && echo && sleep 2

rm skype-installer.deb

unset pw
echo && echo ===== EVERYTHING FINE, HAVE A NICE DAY ==========

