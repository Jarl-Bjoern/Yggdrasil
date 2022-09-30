#!/bin/bash
# Rainer Christian Bjoern Herold
# Vers 0.1 03.05.2022
# Vers 0.2 03.06.2022
# Vers 0.3 24.09.2022
# Vers 0.4 30.09.2022

# Variables
FULL_PATH=$(readlink -f -- "$0")
SCRIPT_NAME=$(basename $BASH_SOURCE)

# Basic_Configuration
sed -i "s#deb http://http.kali.org/kali kali-rolling main contrib non-free#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free#g" /etc/apt/sources.list
apt update -y ; apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all
cat <<EOF >> /etc/crontab
0 6     * * *  root apt update -y ; DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all ; unset DEBIAN_FRONTEND
EOF
sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" ~/.zshrc

# APT_Tools_Installation
input=${FULL_PATH::-${#SCRIPT_NAME}}/Config/APT_minimal_Tools.txt
while IFS= read -r line
do
        apt install -y $line
done < $input

# Python_Tools
pip3 install bloodhound

# Screen_Configuration
cat <<EOF > /home/`ls /home | grep -v "lost+found"`/.screenrc
hardstatus on
hardstatus alwayslastline
hardstatus string "%{.bW}%-w%{.rW}%n %t%{-}%+w %=%{..G} %Y-%m-%d %c "
EOF

# Git_Tools_Installation
input=${FULL_PATH::-${#SCRIPT_NAME}}/Config/Tools.txt
while IFS= read -r line
do
        git clone $line
done < $input
cd /opt ; mkdir kerbrute ; cd kerbrute
wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 -O kerbrute
chmod +x kerbrute ; cd /opt
cd PEASS-ng/metasploit
cp ./peass.rb /usr/share/metasploit-framework/modules/post/multi/gather/
bash /opt/EyeWitness/Python/setup/setup.sh
cd /opt/ssh_scan ; gem install bundler ; bundle install

# Wordlists_Installation
mkdir -p /opt/wordlists ; cd /opt/wordlists
input=${FULL_PATH::-${#SCRIPT_NAME}}/Config/Wordlists.txt
while IFS= read -r line
do
        git clone $line
done < $input

# Metasploit_Configuration
systemctl enable --now postgresql
msfdb init

# Docker_Installation
docker pull mikesplain/openvas
docker pull tenableofficial/nessus
docker run -d -p 127.0.0.1:8834:8834 --rm --name nessus tenableofficial/nessus
docker run -d -p 127.0.0.1:443:443 --rm --name openvas mikesplain/openvas
############################### UPDATE NVT ####################################
#docker exec -it openvas bash
#greenbone-nvt-sync
#openvasmd --rebuild --progress
#greenbone-certdata-sync
#greenbone-scapdata-sync
#openvasmd --update --verbose --progress
#
#/etc/init.d/openvas-manager restart
#/etc/init.d/openvas-scanner restart
#exit
###############################################################################
mkdir /home/$USER/.updater ; chmod 700 /home/$USER/.updater
cat <<EOF > /home/$USER/.updater/image_updater.py
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer C. Bjoern Herold
# 04.06.2022

# Libraries
from subprocess import getoutput
from os import system

# Arrays
Array_Container = getoutput('docker images').splitlines()

# Main
if __name__ == '__main__':
        for i in range(1, len(Array_Container)):
                system(f'docker pull {Array_Container[i].split(" ")[0]};')
EOF
chmod 600 /home/$USER/.updater
cat <<EOF >> /etc/crontab
0 6     * * *  root /usr/bin/env python3 /home/$USER/.updater/image_updater.py
EOF
