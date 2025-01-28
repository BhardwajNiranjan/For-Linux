#!/bin/bash
#----------------------------------------------------------------------
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)
#----------------------------------------------------------------------

if [[ $UID == 0 ]];then   
      echo "${GREEN}Current user is root user${RESET}"
      else 
      echo "${RED}Current user is not root user${RESET}"
      exit 1 
fi

PS3="Select a Number(1,2,3) to Execute the Operation: "
select opt in Install-Nodejs Uninstall-Nodejs Quit; do
    case $opt in
        Install-Nodejs)
         if command -v node >/dev/null; then
             current_version=$(node -v) 
             current_major_version=$(echo $current_version | cut -d'.' -f1 | sed 's/v//') 
             echo "Current Node.js version is: $current_version"
             read -p "Enter the Node.js Version for Installation: " Vno
             if [[ "$current_major_version" == "$Vno" ]]; then
                 echo "${GREEN}The installing Node version Matched ----> No installation needed.${RESET}"
             else
                 echo "${RED}User Input version mismatch!! ::::: Uninstalling the old version and installing Node.js version $Vno...${RESET}"
                 sudo rm -rf /usr/lib/node_modules && apt autoremove -y
                 apt purge --auto-remove nodejs npm -y
                 rm -rf /usr/local/lib/node_modules
                 rm -rf ~/.npm
                 rm -rf ~/.node_repl_history
                 rm -rf /usr/local/bin/node* 
                 rm -rf /usr/local/bin/npm*
                 
                 echo "${GREEN}Install version form user input...........  "
                 apt install -y curl
                 url1="https://deb.nodesource.com/setup_$Vno.x"
                 wget $url1 -O setup_node.sh
                 chmod +x setup_node.sh && bash setup_node.sh
                 apt install -y nodejs
                 npm install -g npm
                 echo "${GREEN}Current Node Version is Showing below...........${RESET}"
                 node -v
                 echo "${GREEN}Current NPM Version is Showing below...........${RESET}"
                 npm -v
             fi
         else
                 echo "${GREEN}Install version form user input...........  "
                 apt install -y curl
                 url1="https://deb.nodesource.com/setup_$Vno.x"
                 wget $url1 -O setup_node.sh
                 chmod +x setup_node.sh && bash setup_node.sh
                 apt install -y nodejs
                 npm install -g npm
                 echo "${GREEN}Current Node Version is Showing below...........${RESET}"
                 node -v
                 echo "${GREEN}Current NPM Version is Showing below...........${RESET}"
                 npm -v
         fi
        ;;
     #----------------------------------------------------------------------------------------
        Uninstall-Nodejs)
            # Uninstall Node.js and related packages
            sudo rm -rf /usr/lib/node_modules && apt autoremove -y
            apt purge --auto-remove nodejs npm -y
            rm -rf /usr/local/lib/node_modules
            rm -rf ~/.npm
            rm -rf ~/.node_repl_history
            rm -rf /usr/local/bin/node* 
            rm -rf /usr/local/bin/npm*

            # Prompt user to continue or exit
            read -p "Do you want to continue or exit? (Y to continue / N to exit): " ans
            answer=${ans,,}  # Convert to lowercase
            
            if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
                # If user wants to continue, re-display the menu
                PS3="Select a Number(1,2,3) to Execute the Operation: "
                select opt in Install-Nodejs Uninstall-Nodejs Quit; do
                    break
                done
            elif [[ "$answer" == "n" || "$answer" == "no" ]]; then
                # Exit the script if the user chooses to exit
                echo "Exiting the script..."
                break
            else
                echo "Invalid input. Exiting the script..."
                break
            fi
        ;;
     #------------------------------------------------------------------------------------------
        Quit)
           break
        ;;
        *) 
           echo "Process Failed.........Retry "
        ;;
    esac
done
