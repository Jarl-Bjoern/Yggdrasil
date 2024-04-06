#!/bin/bash

if [ $1 ]; then
  if [[ -f "$1" ]]; then
    # Install_xclip
    apt install -y xclip
  
    # Remove_Burp
    apt remove -y burpsuite ; apt autoremove --purge -y
  
    # Download_Burp
    website=$(curl -s "https://portswigger.net/burp/releases")
    version=$(echo "$website" | grep -P "professional-community-" | cut -d '"' -f2 | cut -d '/' -f4 | sed 's/professional-community-//g' | sort -ur | head -n1)
    wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=$version&type=Linux" -O "/tmp/burpsuite_pro_v$version.sh" --quiet --show-progress
  
    # Install_Burp
    sudo bash "/tmp/burpsuite_pro_v$version.sh"

    
  else
    echo "The provided argument is not a file or does not exist."
  fi
else
  echo "The path of the license file was missing."
fi
