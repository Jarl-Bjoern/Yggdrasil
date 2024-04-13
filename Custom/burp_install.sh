#!/bin/bash
# Rainer Christian Bjoern Herold

# Color
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
ORANGE='\033[1;33m'
NOCOLOR='\033[0m'

# Variables
TEMP_PATH=$(readlink -f -- "$0")
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
FULL_PATH=${TEMP_PATH::-${#SCRIPT_NAME}-8}

# Main
if [ $1 ]; then
    if [[ -f "$1" ]]; then
        if [[ $("apt-cache policy burpsuite | grep 'Installed: '") ]]; then
            echo -e "${ORANGE}Skipping the deinstallation process of BurpSuite Community.\n${CYAN}-------------------------------------\n${NOCOLOR}"
        else
            # Remove_Burp
            echo -e "${RED}Removing BurpSuite Community.\n${CYAN}-------------------------------------\n${NOCOLOR}"
            sudo apt remove -y burpsuite ; sudo apt autoremove --purge -y
            echo -e "\n${ORANGE}BurpSuite Community was removed.\n${CYAN}-------------------------------------\n${NOCOLOR}"
        fi

        if [[ -d "/opt/BurpSuitePro" ]]; then
            echo -e "${ORANGE}Skipping the download and installation process for BurpSuite Professional.\n${CYAN}-------------------------------------\n${NOCOLOR}"
        else
            # Download_Burp
            echo -e "${ORANGE}Downloading the latest BurpSuite Professional version.\n${CYAN}-------------------------------------\n${NOCOLOR}"
            website=$(curl -s "https://portswigger.net/burp/releases")
            version=$(echo "$website" | grep -P "professional-community-" | cut -d '"' -f2 | cut -d '/' -f4 | sed 's/professional-community-//g' | sort -ur | head -n1 | sed 's/-/./g')
            wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=$version&type=Linux" -O "/tmp/burpsuite_pro_v$version.sh" --quiet --show-progress
    
            # Install_Burp
            echo -e "${ORANGE}Starting the installer.\n${CYAN}-------------------------------------\n${NOCOLOR}"
            sudo bash "/tmp/burpsuite_pro_v$version.sh" &
            sleep 10
            sudo python3 "$FULL_PATH/Resources/Python/auto.py" "Burp" "Install" "TRUE" "EMPTY"
        fi

        # Paste_License
        echo -e "${ORANGE}Starting BurpSuite Professional.\n${CYAN}-------------------------------------\n${NOCOLOR}"
        /opt/BurpSuitePro/BurpSuitePro &
        sleep 10
        sudo python3 "$FULL_PATH/Resources/Python/auto.py" "Burp" "License" "TRUE" "$1"

        if [[ ! -d "/opt/BurpSuitePro" ]]; then
            # Remove_Installer
            rm -f "/tmp/burpsuite_pro_v$version.sh"
        fi
    else
        echo -e "${RED}The provided argument is not a file or does not exist.${NOCOLOR}"
    fi
  else
        echo -e "${RED}The path of the license file was missing.${NOCOLOR}"
fi
