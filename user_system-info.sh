#!/bin/bash
check_system_configuration() {
    echo "========================================"
    echo "        System Configuration Report     "
    echo "========================================"

    echo "Checking CPU information: "
    lscpu | grep -E 'Model name|CPU\(s\)'
    echo
 
    echo " Checking RAM(memory) usage: "
    free -h
    echo

    echo "Checking total and free disk space: "
    df -h --total | grep 'total'
    echo

    echo "Checking the IP address: "
    hostname -I
    echo

    echo "Checking Domain (if joined to a domain): "
    domain=$(hostname -d 2>/dev/null)
    if [[ -z "$domain" ]]; then
        echo "No domain is being used."
    else
        echo "Domain: $domain"
    fi
    echo

    echo "List all users with their permissions: "
    awk -F':' '{ print $1 "\t" $3 "\t" $4 "\t" $6 "\t" $7 }' /etc/passwd | column -t
    echo

    echo "Check running services: "
    for service in ssh apache2 httpd http https; do
        if systemctl is-active --quiet "$service"; then
            echo "$service: Running"
        else
            echo "$service: Not Running"
        fi
    done
    echo "========================================"
    echo
}

#Function to create a new user
create_new_user() {
    read -p "Enter the username: " Uname
    read -s -p "Enter the password: " password && sleep 2s    
    useradd -m -s /bin/bash "$Uname"
    if [[ $? -ne 0 ]]; then
        echo "Failed to create user: $Uname."
        exit 1
    fi
    echo "User $Uname created successfully."

    echo "$username:$password" | chpasswd
    if [[ $? -ne 0 ]]; then
        echo "Failed to set password for $username."
        exit 1
    fi
    echo "Password set successfully for $username."

    # Add the user to the sudo group
    usermod -aG sudo "$username"
    if [[ $? -ne 0 ]]; then
        echo "Failed to grant sudo privileges to $username."
        exit 1
    fi
    echo "Sudo privileges granted to $username."

    # Configure password expiration
    chage -M 45 "$username"
    if [[ $? -ne 0 ]]; then
        echo "Failed to configure password expiration for $username."
        exit 1
    fi
    echo "Password expiration configured: 45 days for $username."

    echo "User $username has been successfully created and configured!"
}

# Main script logic
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root!"
    exit 1
fi

echo "========================================"
echo "         User Management Script         "
echo "========================================"

# Check system configuration
check_system_configuration

# Prompt to create a new user
read -p "Do you want to create a new user? (yes/no): " response
answer=${response,,}          
if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
#if [[ "$response" == "yes" ]]; then
    create_new_user
else
    echo "User creation skipped."
fi
