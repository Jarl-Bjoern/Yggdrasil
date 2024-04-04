#!/bin/bash

if [ $1 ]; then
  # Remove_Burp
  apt remove -y burpsuite ; apt autoremove --purge -y

  # Download_Burp
  website=$(curl -s "https://portswigger.net/burp/releases")
  version=$(echo "$html" | grep -P "professional-community-" | cut -d '"' -f2 | cut -d '/' -f4 | sort -ur | head -n1)
  wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=$version&type=sh" -O "burpsuite_pro_v$version.sh" --quiet --show-progress

  # Install_Burp
  sudo bash "burpsuite_pro_v$version.sh"
  
else
  echo "The path of the license file was missing."
fi
