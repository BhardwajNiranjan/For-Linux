#!/bin/bash
         echo -e "\033[34m ------------- Checking the Logged User is Root or Not -------------"
if [ "$(id -u)" -ne 0 ]; then
         echo -e "\033[33m -----This Script Must be Run as Root-----"
         echo -e "\033[32m"
         exit 1
         else
         apt  update -y 
         apt upgrade -y
         apt install openjdk-11-jdk -y 
 
      if [ $? -ne 0 ]; then
         echo -e "\033[31m Failed to update package list. Exiting."
         echo -e "\033[33m"
         exit 1
         else
         echo -e "\033[32m Installing Docker..."
         echo -e "\033[34m"
         apt install -y docker.io

      if [ $? -ne 0 ]; then
         echo -e "\033[31m Failed to install Docker. Exiting."
         echo -e "\033[35m"
         exit 1
      fi
         echo -e "\033[36m Docker installed successfully."
         echo -e "\033[32m"
     fi

 #echo " Setup is Successfully Installed "
fi 

JavaVer=$(java --version)
DockerVer=$(docker --version)

echo -e "\033[35m The Current Version of Java is: $JavaVer \nThe Current Version of Docker is: $DockerVer"
