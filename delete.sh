#!/bin/bash 
read -p "enter a package name which you want to uninstalled: "  package_name
apt remove $package_name
apt purge $package_name -y 
apt-get purge $package_name* -y 
apt-get --purge autoremove -y  
apt-get clean $package_name* -y  
apt-get autoremove $package_name -y 
dpkg --remove $package_name -y 
dpkg --remove $package_name* -y 
apt install update 
apt install --fix-missing -y  
apt install upgrade -y 
