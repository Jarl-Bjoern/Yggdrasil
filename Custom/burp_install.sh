#!/bin/bash
# Rainer Christian Bjoern Herold

# Variables
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
FULL_PATH=${TEMP_PATH::-${#SCRIPT_NAME}-21}

# Main
if [ $1 ]; then
  if [[ -f "$1" ]]; then
    # Install_xclip
    sudo apt install -y xclip
  
    # Remove_Burp
    sudo apt remove -y burpsuite ; sudo apt autoremove --purge -y
  
    # Download_Burp
    website=$(curl -s "https://portswigger.net/burp/releases")
    version=$(echo "$website" | grep -P "professional-community-" | cut -d '"' -f2 | cut -d '/' -f4 | sed 's/professional-community-//g' | sort -ur | head -n1 | sed 's/-/./g')
    wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=$version&type=Linux" -O "/tmp/burpsuite_pro_v$version.sh" --quiet --show-progress

    # Clipboard_Cleaner
    touch "" > /tmp/clean.txt

    # Read_License
    xclip "$1"
  
    # Install_Burp
    sudo bash "/tmp/burpsuite_pro_v$version.sh"
    sudo python3 "$FULL_PATH/Resources/Python/auto.py" "Burp" "Install"

    # Paste_License
    /opt/BurpSuitePro/BurpSuitePro
    sudo python3 "$FULL_PATH/Resources/Python/auto.py" "Burp" "License"
    # UNDER CONSTRUCTION

    # Remove_Installer
    rm -f "/tmp/burpsuite_pro_v$version.sh"

    # Clear_Clipboard
    xclip /tmp/clean.txt ; rm -f /tmp/clean.txt
  else
    echo "The provided argument is not a file or does not exist."
  fi
else
  echo "The path of the license file was missing."
fi
