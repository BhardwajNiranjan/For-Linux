#!/bin/bash

if [ $UID -eq 0 ]; then
   echo "-------------------> Root user is logged in <---------------------"
   read -p "Enter Full username: " name
   read -p "Enter User Email'Id: "  mail
    apt update 
    apt install git -y  
    git --version
    apt install make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip -y
    apt update -y && apt upgrade -y    
    git config --global user.name $name
    git config --global user.email $mail
    git config --list
    git init 
    if [ $? -eq 0 ]; then
    echo "--------------------Git Setup successfully Done--------------------"
    Version=$(git --version)
    UserDetails=$(git config --list)
    Status=$(git status)
    echo -e "Current Version is: $Version \nGit Creds is: $UserDetails \nThe Current Status is: $Status"
    else
    echo "Previous Command Encountered an Error (Exit Status $?)."
   fi 
 else
   echo "Root user is not logged in."
fi

