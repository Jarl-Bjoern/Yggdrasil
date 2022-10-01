#!/bin/bash
# Rainer Christian Bjoern Herold
# Vers 0.1 03.05.2022
# Vers 0.2 03.06.2022
# Vers 0.3 24.09.2022
# Vers 0.4 30.09.2022

##################### BURP PLUGINS & Configuration ###########################
# apt install -y jython
# /usr/bin/jython
#
# EsPReSSO
# Freddy, Deserialization Bug Finder
# Copy As Python-Requests
# ActiveScan++
# Additional Scanner Checks
# AuthMatrix
# Autorize
# Backslash Powered Scanner
# CSRF Scanner
# Error Message Checks
# ExifTool Scanner
# GWT Insertion Points
# Flow
# Java Deserialization Scanner
# JSON Web Token Attacker
# J2EEScan
# .NET Beautifier
# NTLM Challenge Decoder
# PHP Object Injection Check
# PDF Metadata
# Retire.js
# Software Vulnerability Scanner
# WAFDetect
# Software Version Reporter
# WCF Deserializer
# Wsdler
# GraphQL Raider

# Upstream Proxy Servers
# * 127.0.0.1 8080
#
# SOCKS Proxy
# 127.0.0.1
# 1234
#################################################################################

# Variables
IP_INT=127.0.0.1
IP_EXT=127.0.0.1
BENUTZER=`cat /etc/passwd | grep $USER | cut -d':' -f3`
FULL_PATH=$(readlink -f -- "$0")
SCRIPT_NAME=$(basename $BASH_SOURCE)

# Functions
function initials {
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "|                    Kali Configurator                   |"
        echo "|                       Version 0.4                      |"
        echo "|             Rainer Christian Bjoern Herold             |"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo ""
}

# Installation_Type
initials
echo "Please choose between a installation"
echo "------------------------------------"
echo ""
echo "full : full installation (GUI)      "
echo "minimal : minimal installation (CLI)"
echo "special : special installation      "
echo ""

read -p "Your Choice: " decision
if [ $decision = "full" ]; then
	declare -a Array_Path=(
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/APT_Tools.txt"
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/GIT_Tools.txt"
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/Wordlists.txt")
elif [ $decision = "minimal" ]; then
        declare -a Array_Path=(
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/APT_minimal_Tools.txt"
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/GIT_Tools.txt"
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/Wordlists.txt")
elif [ $decision = "special" ]; then
        declare -a Array_Path=(
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/APT_minimal_Tools.txt"
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/GIT_Tools.txt"
	"${FULL_PATH::-${#SCRIPT_NAME}}/Config/Wordlists.txt")
else
        echo "Your decision was not accepted!"
        echo "Please try again."
	exit
fi

# Clear
sleep 2 ; clear ; initials

# Basic_Configuration
sed -i "s#deb http://http.kali.org/kali kali-rolling main contrib non-free#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free#g" /etc/apt/sources.list
apt update -y ; apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all
sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" ~/.zshrc
cat <<EOF >> /etc/crontab
0 6     * * *  root apt update -y ; DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all ; unset DEBIAN_FRONTEND
EOF

# Tool_Installation
for i in ${Array_Path[@]}; do
	if [[ $i =~ "Wordlists" ]]; then
		mkdir -p /opt/wordlists ; cd /opt/wordlists
	else
		cd /opt
	fi
	input=$i
	while IFS= read -r line
	do
		if [[ $i =~ "APT" ]]; then
        		apt install -y $line
		else
			git clone $line
		fi
	done < $input
done

# Python_Tools
pip3 install bloodhound

# Screen_Configuration
cat <<EOF > /home/`ls /home | grep -v "lost+found"`/.screenrc
hardstatus on
hardstatus alwayslastline
hardstatus string "%{.bW}%-w%{.rW}%n %t%{-}%+w %=%{..G} %Y-%m-%d %c "
EOF

# Git_Tools_Installation
cd /opt ; mkdir kerbrute ; cd kerbrute
wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 -O kerbrute
chmod +x kerbrute ; cd /opt
cd PEASS-ng/metasploit
cp ./peass.rb /usr/share/metasploit-framework/modules/post/multi/gather/
bash /opt/EyeWitness/Python/setup/setup.sh
cd /opt/ssh_scan ; gem install bundler ; bundle install
if [ $decision = "full" ]; then
	wget https://dl.pstmn.io/download/latest/linux64
	tar -xzvf linux64 -C /tmp/
	chown -R root: /tmp/Postman
	mv /tmp/Postman /opt/
	ln -s /opt/Postman/app/Postman /usr/local/bin/postman
fi

if [ $decision != "special" ]; then
	########################################################################
	# Line 1-2 Protecting against IP-Spoofing                              #
	# Line 3 Protecting against SYN flood attacks                          #
	# Line 4 Protecting against time-wait-assassination                    #
	# Line 5-12 Protecting against MITM                                    #
	# Line 13 Protecting against ICMP Smurf Attacks                        #
	# Line 14-18 Protecting against MITM - Redirecting network traffic     #
	# Line 19-20 Protecting against MITM - ipv6                            #
	# Line 21-23 Protecting against TCP-SACK Exploits                      #
	########################################################################
	declare -a Array_SED=("net.ipv4.conf.default.rp_filter=1"
	"net.ipv4.conf.all.rp_filter=1"
	"net.ipv4.tcp_syncookies=1"
	"net.ipv4.tcp_rfc1337=1"
	"net.ipv4.conf.all.accept_redirects=0"
	"net.ipv4.conf.default.accept_redirects=0"
	"net.ipv4.conf.all.secure_redirects=0"
	"net.ipv4.conf.default.secure_redirects=0"
	"net.ipv6.conf.all.accept_redirects=0"
	"net.ipv6.conf.default.accept_redirects=0"
	"net.ipv4.conf.all.send_redirects=0"
	"net.ipv4.conf.default.send_redirects=0"
	"net.ipv4.icmp_echo_ignore_all=1"
	"net.ipv4.conf.all.accept_source_route=0"
	"net.ipv4.conf.default.accept_source_route=0"
	"net.ipv6.conf.all.accept_source_route=0"
	"net.ipv6.conf.default.accept_source_route=0"
	"net.ipv6.conf.all.accept_ra=0"
	"net.ipv6.conf.default.accept_ra=0"
	"net.ipv4.tcp_sack=0"
	"net.ipv4.tcp_dsack=0"
	"net.ipv4.tcp_fack=0"
	)
	for i in ${Array_SED[@]}; do
		sed -i 's/#$i/$i/g' /etc/sysctl.conf
	done
	
	# Firewall_Configuration
	cat <<EOF >> /etc/iptables/rules.v4
	# /etc/iptables/rules.v4:
	# Generated by iptables-save v1.6.2 on Thu Mar 22 12:02:23 2018
	*filter
	:INPUT DROP [0:0]
	:FORWARD ACCEPT [0:0]
	:OUTPUT ACCEPT [0:0]
	# Allow established, related and localhost traffic
	-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	-A INPUT -s 127.0.0.0/8 -j ACCEPT
	# Allow incoming PING
	-A INPUT -p icmp --icmp-type 8 -s 0/0 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT -m comment --comment "ACCEPT icmp echo (ping) requests"
	# Allow incoming SSH connections
	#-A INPUT -p tcp --dport 22 -j ACCEPT -m comment --comment "ACCEPT ssh connections to port 22/tcp"
	# Other stuff like reverse-shell access et alii
	# -A INPUT -i eth2 -s 123.123.123.123 -p tcp --dport 4444 -j ACCEPT -m comment --comment "Reverse Shell 4444/tcp"
	# Commit all changes
	COMMIT
	# Completed on Thu Mar 22 12:02:23 2018
	EOF
	cat <<EOF > /etc/iptables/rules.v6
	# /etc/iptables/rules.v6:
	# Generated by ip6tables-save v1.6.2 on Thu Mar 22 12:02:23 2018
	*filter
	:INPUT DROP [0:0]
	:FORWARD ACCEPT [0:0]
	:OUTPUT ACCEPT [0:0]
	# Accept all established and related connections
	-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	# Accept all connections originating from Link-Local
	-A INPUT -s ::1/128 -j ACCEPT
	-A INPUT -m conntrack --ctstate NEW -s fe80::/10 -j ACCEPT
	# Permit needed ICMP packet types for IPv6 per RFC 4890.
	-A INPUT              -p ipv6-icmp --icmpv6-type 1   -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 2   -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 3   -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 4   -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 133 -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 134 -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 135 -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 136 -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 137 -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 141 -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 142 -j ACCEPT
	-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 130 -j ACCEPT
	-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 131 -j ACCEPT
	-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 132 -j ACCEPT
	-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 143 -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 148 -j ACCEPT
	-A INPUT              -p ipv6-icmp --icmpv6-type 149 -j ACCEPT
	-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 151 -j ACCEPT
	-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 152 -j ACCEPT
	-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 153 -j ACCEPT
	# Commit all changes
	COMMIT
	# Completed on Thu Mar 22 12:02:23 201
	EOF
	chmod 0600 /etc/iptables/*
	systemctl enable --now netfilter-persistent.service
	
	# SSH_Configuration
	sed -i "s/#ListenAddress 0.0.0.0/ListenAddress $IP_EXT:33033\nListenAddress $IP_INT:22/g" /etc/ssh/sshd_config
	sed -i "s/#LogLevel INFO/LogLevel VERBOSE/g" /etc/ssh/sshd_config
	sed -i "s/#MaxAuthTries 6/MaxAuthTries 12/g" /etc/ssh/sshd_config
	sed -i "s/#UseDNS no/UseDNS no/g" /etc/ssh/sshd_config
	sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
	sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
	cat <<EOF >> /etc/ssh/sshd_config
	KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
	# Host-key algorithms
	HostKeyAlgorithms ssh-ed25519
	# Encryption algorithms (ciphers)
	Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
	# Message authentication code (MAC) algorithms
	MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com
	EOF
	systemctl restart sshd.service
fi

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
chmod 600 /home/$USER/.updater/image_updater.py
cat <<EOF >> /etc/crontab
0 6     * * *  root /usr/bin/env python3 /home/$USER/.updater/image_updater.py
EOF
