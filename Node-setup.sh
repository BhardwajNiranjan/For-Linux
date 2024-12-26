#!/bin/bash
if [[ $UID == 0 ]];then   
      echo " Current user is root user "
      else 
      echo -e " \033[0;31m The Current user is not: root user "
      exit 1 
fi

PS3="Select a Number(1,2,3) to Execute the Operation: "
select opt in Install_Node Uninstall_Node Quit; do
 case $opt in
     Install_Node)
             apt install -y curl
             apt install nodejs -y
             node -v
             apt install npm -y
             npm -v 
             echo "Installing NVM (Node Version Manager)..."
             curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
 
         export NVM_DIR="$HOME/.nvm"
         [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
         source ~/.bashrc
         source ~/.bash_profile
       if ! command -v nvm &>/dev/null; then
         echo "NVM installation failed. Exiting."
         exit 1
       fi
 
         echo "Fetching all available Node.js versions..."
         nvm ls-remote
 
       read -p "Enter the Node.js version which you want to install (ex, 18.4.0): " NODE_VERSION
       if [[ -z "$NODE_VERSION" ]]; then
          echo "No version entered. Exiting....."
          exit 1
       fi
 
       echo "Installing Node.js version $NODE_VERSION..."
       nvm install "$NODE_VERSION"
       node use $NODE_VERSION
       current_version1=$(nvm --version)
       current_version2=$(npm --version)
       echo "The current Node running version is:  $current_version1 "
       echo "The current NPM running version is:  $current_version2 "
       Vlist=$(nvm ls)
       echo "Current listed all Version: $Vlist "
      ;;
 
      Uninstall_Node)
             #read -p "enter package name: " pck
            read -p "Are you want to uninstall node.js or npm: (yes/no): " ans
            answer=${ans,,}          
            if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
               apt purge node* -y && apt purge nodejs* && apt remove node*
               apt remove nvm -y && rm -rf usr/local/bin/npm* && sudo rm -rf /usr/local/lib/node_modules
               rm -rf /usr/local/bin/npm* && rm -rf /usr/local/share/man/man1/node* 
               rm -rf /usr/local/lib/dtrace/node.d && rm -rf ~/.npm* && rm -rf ~/.node* && rm -rf ~/.nvm* && rm -rf ~/.node-gyp
               rm -rf /opt/local/bin/node* && rm -rf /opt/local/include/node*
               rm -rf /opt/local/lib/node* && rm -rf /usr/local/lib/node*
               rm -rf /usr/local/include/node* && rm -rf /usr/local/bin/node*
               Status=$(which node)
               #details=$(dpkg -s $Status) 
               sleep 3s && echo "Status of Node: $Status "  
             elif [[ "$answer" == "no" || "$answer" == "n" ]]; then
               echo "You chose no. Exiting..."
             else
               echo "Invalid input. Please type 'yes' or 'no'."
           fi
     ;;
    
      Quit)
          break
     ;;
     *) 
      echo "Process Failed..Due to Error Code: $? -> Retry"
     ;;
 esac
done
