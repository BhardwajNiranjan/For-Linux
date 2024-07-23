#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
aplay -l
lsmod | grep snd -y 
lspci | grep -i audio -y
lsusb | grep -i audio -y
sudo apt-get install pavucontrol -y
sudo apt install alsa-utils pulseaudio pavucontrol -y
sudo apt install bluez bluez-tools rfkill -y
sudo systemctl enable bluetooth -y
sudo systemctl start bluetooth -y
systemctl status bluetooth -y
bluetoothctl
sudo apt install alsa-utils -y
alsamixer
sudo apt install pulseaudio pavucontrol -y
pavucontrol

echo "System is Rebooting............."

sudo reboot
