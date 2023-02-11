#!/bin/bash
# TP-Link 821n V6
sudo DEBIAN_FRONTEND=noninteractive apt install -y bc build-essential dkms firmware-realtek linux-headers-generic realtek-rtl8188eus-dkms
sudo mkdir -p /opt/drivers ; cd /opt/drivers || return 0 ; sudo git clone https://www.github.com/Mange/rtl8192eu-linux-driver ; cd rtl8192eu-linux-driver || return 0
sudo make &&
sudo make install &&
echo "rtl8192eu" > /etc/modprobe.d/blacklist.conf &&
echo "Installation completed"
