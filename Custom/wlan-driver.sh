#!/bin/bash
# Rainer Christian Bjoern Herold
# ALFA AWUS036ACS
sudo apt install -y realtek-rtl88xxau-dkms

# TP-Link 821n V6
sudo DEBIAN_FRONTEND=noninteractive apt install -y bc build-essential dkms firmware-realtek linux-headers-generic realtek-rtl8188eus-dkms
sudo mkdir -p /opt/drivers ; cd /opt/drivers || return 0 ; sudo git clone https://www.github.com/Mange/rtl8192eu-linux-driver ; cd rtl8192eu-linux-driver || return 0
sudo make &&
sudo make install &&
echo "rtl8192eu" > /etc/modprobe.d/blacklist.conf &&

# ALFA AWUS1900
sudo DEBIAN_FRONTEND=noninteractive apt install -y linux-headers-$(uname -r) build-essential bc dkms git libelf-dev rfkill iw realtek-rtl8814au-dkms
sudo mkdir -p /opt/drivers ; cd /opt/drivers || return 0 ; sudo git clone https://github.com/morrownr/8814au ; cd 8814au || return 0
cat <<EOF | sudo bash install-driver.sh
n
y
EOF
