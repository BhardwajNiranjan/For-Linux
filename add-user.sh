#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root!"
    exit 1
fi

# Get the username and password from the user
read -p "Enter the username: " username
read -s -p "Enter the password: " password
echo

# Create the new user
useradd -m -s /bin/bash "$username"
if [[ $? -ne 0 ]]; then
    echo "Failed to create user $username."
    exit 1
fi
echo "User $username created successfully."

# Set the user's password
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
