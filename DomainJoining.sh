#!/bin/bash
echo "Checking Current User is Root User or not"
 if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
else
       echo "User is root, System Update is in Running..........."
       apt update -y
       apt dist-upgrade -y
       apt autoremove -y      
       apt clean -y
fi   

echo "-----------------------------------------------------------------"

if [ $? == 0 ]
    then
       read -p "Enter your Domain Name: " domain
       apt update
       apt install realmd sssd sssd-tools adcli krb5-user
       realm join $domain
       systemctl restart sssd
       sudo pam-auth-update --enable mkhomedir
       realm list
     if [ $? == 0 ]
         then
          echo "Domain Login Successfully, Now Check Domain Details Below"
         read -p "Enter Full Domain Name: " $DomainMail
         getent passwd  $DomainMail
      else
        echo ""
    fi
 else
       echo "Error Code is:" $? && echo "Try Again"
fi 




