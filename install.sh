#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]; then
    echo "This script will be run as root"
   else 
 echo "User is root, Proceeding Next......"
 echo "----------------------------------------------------------------------------------------"


# Update package lists
apt update -y
apt dist-upgrade -y
apt autoremove -y      # Remove unused dependencies
apt clean -y           # Clear out cached packages from the local repository

# Install Google Chrome
apt install -y wget
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt install -f -y

# Install Skype
wget https://go.skype.com/skypeforlinux-64.deb
dpkg -i skypeforlinux-64.deb
apt install -f -y

# Install Visual Studio Code
snap install --classic code

# Clean up downloaded deb files (optional)
rm google-chrome-stable_current_amd64.deb skypeforlinux-64.deb

echo "Installation completed."

fi 

