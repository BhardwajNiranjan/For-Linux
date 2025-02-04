#!/bin/bash

# Function to install Chrome
install_chrome() {
    echo "Installing Google Chrome..."
    wget -q -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i /tmp/google-chrome.deb
    sudo apt-get install -f -y
    echo "Google Chrome installed!"
}

# Function to install Skype
install_skype() {
    echo "Installing Skype..."
    wget -q -O /tmp/skype.deb https://go.skype.com/skypeforlinux-64.deb
    sudo dpkg -i /tmp/skype.deb
    sudo apt-get install -f -y
    echo "Skype installed!"
}

# Function to install VSCode
install_vscode() {
    echo "Installing Visual Studio Code..."
    wget -q -O /tmp/vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
    sudo dpkg -i /tmp/vscode.deb
    sudo apt-get install -f -y
    echo "Visual Studio Code installed!"
}

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    sudo apt update -y && sudo apt upgarde -y
    sudo apt  install docker.io -y
    echo "Docker installed!"
}

# Function to install MySQL
install_mysql() {
    echo "Installing MySQL..."
    sudo apt-get update
    sudo apt-get install -y mysql-server
    echo "MySQL installed!"
}

# Function to install MongoDB
install_mongodb() {
    echo "Installing MongoDB..."
    sudo apt-get update
    sudo apt-get install -y mongodb
    echo "MongoDB installed!"
}

# Function to install Git
install_git() {
    echo "Installing Git..."
    sudo apt-get update
    sudo apt-get install -y git
    echo "Git installed!"
}

# Function to install GitHub Desktop
install_github_desktop() {
    echo "Installing GitHub Desktop..."
    wget -q -O /tmp/github-desktop.deb https://github.com/shiftkey/desktop/releases/download/release-2.8.0-linux1/GitHubDesktop-linux-2.8.0-linux1.deb
    sudo dpkg -i /tmp/github-desktop.deb
    sudo apt-get install -f -y
    echo "GitHub Desktop installed!"
}

# Function to install Docker Desktop
install_docker_desktop() {
    echo "Installing Docker Desktop..."
    apt install gnome-terminal && modprobe kvm
    modprobe kvm_intel
    modprobe kvm_amd 
    kvm-ok && systemctl --user enable docker-desktop && systemctl --user start docker-desktop
    sudo usermod -aG kvm $USER
    wget -i https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64&_gl=1*s89w64*_gcl_au*MTA1MDEzNjM4LjE3Mzg2NjExMjI.*_ga*OTA5ODc1OTE5LjE3MzgwNDMzMzc.*_ga_XJWPQMJYHQ*MTczODY2MTEyMi4yLjEuMTczODY2MTM5MC40OC4wLjA.
    dpkg --configure -a 
    apt update -y >/dev/null && apt install -f -y
}

# Function to install AWS CLI
install_aws_cli() {
    echo "Installing AWS CLI..."
    sudo apt-get update
    sudo apt-get install -y awscli
    echo "AWS CLI installed!"
}

# Function to install PostgreSQL
install_postgresql() {
    echo "Installing PostgreSQL..."
    sudo apt-get update
    sudo apt-get install -y postgresql
    echo "PostgreSQL installed!"
}

# Main script

# Array of application names
options=(
    "Google Chrome"
    "Skype"
    "Visual Studio Code"
    "Docker"
    "MySQL"
    "MongoDB"
    "Git"
    "GitHub Desktop"
    "Docker Desktop"
    "AWS CLI"
    "PostgreSQL"
    "Quit"
)

# Select loop
PS3="Select an application to install (or press 'e' to exit): "
select opt in "${options[@]}"; do
    case "$opt" in
        "Google Chrome")
            install_chrome
            ;;
        "Skype")
            install_skype
            ;;
        "Visual Studio Code")
            install_vscode
            ;;
        "Docker")
            install_docker
            ;;
        "MySQL")
            install_mysql
            ;;
        "MongoDB")
            install_mongodb
            ;;
        "Git")
            install_git
            ;;
        "GitHub Desktop")
            install_github_desktop
            ;;
        "Docker Desktop")
            install_docker_desktop
            ;;
        "AWS CLI")
            install_aws_cli
            ;;
        "PostgreSQL")
            install_postgresql
            ;;
        "e")
            echo "Exiting..."
            exit1
            ;;
        *) 
            echo "Invalid option. Please select a valid number."
            ;;
    esac
done
