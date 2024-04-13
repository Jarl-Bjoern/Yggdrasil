#!/bin/bash
# Rainer Christian Bjoern Herold

# Variables
TEMP_PATH=$(readlink -f -- "$0")
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
FULL_PATH=${TEMP_PATH::-${#SCRIPT_NAME}-8}

# Main
if [ $1 ]; then
    if [[ -f "$1" ]]; then
        # Remove_Burp
        sudo apt remove -y burpsuite ; sudo apt autoremove --purge -y

        # Download_Burp
        website=$(curl -s "https://portswigger.net/burp/releases")
        version=$(echo "$website" | grep -P "professional-community-" | cut -d '"' -f2 | cut -d '/' -f4 | sed 's/professional-community-//g' | sort -ur | head -n1 | sed 's/-/./g')
        wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=$version&type=Linux" -O "/tmp/burpsuite_pro_v$version.sh" --quiet --show-progress

        # Install_Burp
        sudo bash "/tmp/burpsuite_pro_v$version.sh" &
        sudo python3 "$FULL_PATH/Resources/Python/auto.py" "Burp" "Install" "EMPTY"

        # Paste_License
        /opt/BurpSuitePro/BurpSuitePro &
        sudo python3 "$FULL_PATH/Resources/Python/auto.py" "Burp" "License" "$1"

        # Remove_Installer
        rm -f "/tmp/burpsuite_pro_v$version.sh"
    else
        echo "The provided argument is not a file or does not exist."
    fi
  else
        echo "The path of the license file was missing."
fi
