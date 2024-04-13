#!/bin/bash
# Rainer Christian Bjoern Herold

# Variables
TEMP_PATH=$(readlink -f -- "$0")
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
FULL_PATH=${TEMP_PATH::-${#SCRIPT_NAME}-8}

# Main
if [ $1 ]; then
    if [[ -f "$1" ]]; then
        if [[ $("apt-cache policy burpsuite | grep 'Installed: '") ]];
            echo "Skipping the deinstallation process of BurpSuite Community."
        else
            # Remove_Burp
            echo "Removing BurpSuite Community."
            sudo apt remove -y burpsuite ; sudo apt autoremove --purge -y
            echo "BurpSuite Community was removed."
        fi

        if [[ -d "/opt/BurpSuitePro" ]]; then
            echo "Skipping the download and installation process for BurpSuite Professional."
        else
            # Download_Burp
            echo "Downloading the latest BurpSuite Professional version."
            website=$(curl -s "https://portswigger.net/burp/releases")
            version=$(echo "$website" | grep -P "professional-community-" | cut -d '"' -f2 | cut -d '/' -f4 | sed 's/professional-community-//g' | sort -ur | head -n1 | sed 's/-/./g')
            wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=$version&type=Linux" -O "/tmp/burpsuite_pro_v$version.sh" --quiet --show-progress
    
            # Install_Burp
            echo "Starting the installer."
            sudo bash "/tmp/burpsuite_pro_v$version.sh" &
            sleep 10
            sudo python3 "$FULL_PATH/Resources/Python/auto.py" "Burp" "Install" "TRUE" "EMPTY"
        fi

        # Paste_License
        echo "Starting BurpSuite Professional"
        /opt/BurpSuitePro/BurpSuitePro &
        sleep 10
        sudo python3 "$FULL_PATH/Resources/Python/auto.py" "Burp" "License" "TRUE" "$1"

        if [[ ! -d "/opt/BurpSuitePro" ]]; then
            # Remove_Installer
            rm -f "/tmp/burpsuite_pro_v$version.sh"
        fi
    else
        echo "The provided argument is not a file or does not exist."
    fi
  else
        echo "The path of the license file was missing."
fi
