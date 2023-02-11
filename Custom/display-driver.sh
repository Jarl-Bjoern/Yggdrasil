#!/bin/bash

sudo mkdir -p /opt/drivers ; cd /opt/drivers || return 0
sudo git clone https://github.com/AdnanHodzic/displaylink-debian
cd displaylink-debian || return 0
sudo DEBIAN_FRONTEND=noninteractive apt install -y unzip linux-headers-$(uname -r) dkms lsb-release linux-source x11-xserver-utils wget libdrm-dev libelf-dev git pciutils
cat <<EOF | sudo bash displaylink-debian.sh
i
Y
n
EOF
