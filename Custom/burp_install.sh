#!/bin/bash

if [ $1 ]; then
  # Remove_Burp
  apt remove -y burpsuite ; apt autoremove --purge -y
  
  # Install_Burp
else
  echo "The path of the license file was missing."
fi
