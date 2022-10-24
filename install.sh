#!/bin/bash
# Rainer Christian Bjoern Herold
# Vers 0.1 03.05.2022
# Vers 0.2 03.06.2022
# Vers 0.3 24.09.2022
# Vers 0.4 30.09.2022
# Vers 0.5 01.10.2022
# Vers 0.5c 01.10.2022
# Vers 0.5d 04.10.2022
# Vers 0.6 07.10.2022
# Vers 0.6b 08.10.2022
# Vers 0.6c 18.10.2022
# Vers 0.6d 22.10.2022
# Vers 0.7 24.10.2022

# Variables
IP_INT=127.0.0.1
FULL_PATH=$(readlink -f -- "$0")
SCRIPT_NAME=$(basename $BASH_SOURCE)
PATH_SCREEN=""
Skip=false
Switch_WGET=false

# Arrays
declare -a Array_SSH_Ciphers=("# Keyexchange algorithms"
"KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256"
"# Host-key algorithms"
"HostKeyAlgorithms ssh-ed25519"
"# Encryption algorithms (ciphers)"
"Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com"
"# Message authentication code (MAC) algorithms"
"MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com")

# Color
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[1;33m'
NOCOLOR='\033[0m'

# Functions
function initials {
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "|                    Kali Configurator                   |"
        echo -e "|                       Version ${CYAN}0.7${NOCOLOR}                      |"
        echo "|             Rainer Christian Bjoern Herold             |"
        echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
}

function clearing {
	sleep 2 ; clear ; initials
}

function header() {
	clear ; initials
	if [ $1 = "category" ]; then
		echo -e "\n          Please choose between one category"
	elif [ $1 = "installation" ]; then
		echo -e "\n          Please choose between one installation"
	fi
	echo "----------------------------------------------------------"
	echo "|                                                        |"
	if [ $1 = "category" ]; then
		echo -e "|     ${RED}complete${NOCOLOR}    :   installation of both tools         |"
		echo -e "|     ${GREEN}forensic${NOCOLOR}    :   installation of forensic tools     |"
		echo -e "|     ${ORANGE}pentest${NOCOLOR}     :   installation of pentest tools      |"
	elif [ $1 = "installation" ]; then
		echo -e "|            ${GREEN}full${NOCOLOR}    : full installation (GUI)           |"
		echo -e "|            ${ORANGE}minimal${NOCOLOR} : minimal installation (CLI)        |"
	elif [ $1 = "pentesting_category" ]; then
		echo -e "|     ${GREEN}infrastructure${NOCOLOR}  :   tools for infra pentesting     |"
		echo -e "|     ${ORANGE}iot${NOCOLOR}             :   tools for iot pentesting       |"
		echo -e "|     ${RED}red_teaming${NOCOLOR}     :   tools for red teaming          |"
		echo -e "|     ${GREEN}web${NOCOLOR}             :   tools for web pentesting       |"
	fi
	echo "|                                                        |"
	echo -e "----------------------------------------------------------\n"
}

# Category
header "category"
read -p "Your Choice: " category_type
if [ $category_type = "forensic" ]; then
	Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Forensic"
	OPT_Path="/opt/forensic_tools"
elif [ $category_type = "pentest" ];  then
	Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Pentest"
	OPT_Path="/opt/pentest_tools"
elif [ $category_type = "complete" ]; then
        echo -e "\nUNDER CONSTRUCTION!\nPlease try again." ; exit
	#Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config"
else
        echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
fi

# Installation_Type
header "installation"
read -p "Your Choice: " decision
if [ $decision = "full" ]; then
	File_Path="${Path_Way}/full_install.txt"
	if [ $category_type = "pentest" ];  then
		Informational="${FULL_PATH::-${#SCRIPT_NAME}}/Information/info.txt"
	fi
elif [ $decision = "minimal" ];  then
	File_Path="${Path_Way}/minimal_install.txt"
else
        echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
fi

# SSH_IP_Address
clearing
if [[ $1 != "-s" ]]; then
	NIC=$(ip a | grep "state UP" | cut -d " " -f2 | grep -v -E "lo|docker|veth")
	IP=$(ifconfig | grep "inet" | grep -v "inet6" | cut -d " " -f10 | grep -v -E "127.0.0.1|172.17.0.1" | sort -u)
	readarray -t ARRAY_NIC <<< "$NIC" ; readarray -t ARRAY_IP <<< "$IP"

	echo -e "\n           Please select an IP address to be used\n                   for SSH configuration"
	echo -e "----------------------------------------------------------\n"
	n=0
	while [[ n -le ${#ARRAY_NIC[@]} ]]; do
        	echo -e "                  " ${ORANGE}${ARRAY_NIC[n]}${NOCOLOR} ${ARRAY_IP[n]}
        	n=$((n + 1))
	done
	echo -e "----------------------------------------------------------\n"
	read -p "Your Choice: " IP_TEMP
	if [[ ${#IP_TEMP} -gt 0 ]]; then
		LEN_CHECK=$(ip a | grep "$IP_TEMP")
		if [[ ${#LEN_CHECK} -gt 0 ]] && [[ ${IP_TEMP} = *"."* ]]; then
			IP_INT=$IP_TEMP
			clearing
		else
			echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
		fi
	else
		echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
	fi
fi

# Basic_Configuration
if [[ $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d '"' -f2) =~ "Kali GNU/Linux" ]]; then
	sudo sed -i "s#deb http://http.kali.org/kali kali-rolling main contrib non-free#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free#g" /etc/apt/sources.list
	sudo sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" ~/.zshrc
fi
sudo apt update -y ; sudo apt full-upgrade -y ; sudo apt autoremove -y --purge ; sudo apt clean all
export HISTCONTROL=ignoreboth:erasedups
LEN_CRON=$(cat /etc/crontab | grep -E "apt full-upgrade -y ; apt autoremove -y --purge")
if [[ !${#LEN_CRON} -gt 0 ]]; then
	cat <<'EOF' >> /etc/crontab
0 6     * * *  root apt update -y ; DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all ; unset DEBIAN_FRONTEND
0 6     * * *  root for Cont_IMG in $(docker images | cut -d " " -f1 | grep -v "REPOSITORY"); do docker pull $Cont_IMG; done
0 5     * * *  root pip3 install --upgrade pip setuptools python-debian
EOF
fi

# Tool_Installation
input=$File_Path
while IFS= read -r line
do
        if [[ $line = "# APT" ]]; then
                Command="sudo apt install -y" ; Skip=true ; Switch_WGET=false
	elif [[ $line = "# Cargo" ]]; then
		Command="sudo cargo install" ; Skip=true ; Switch_WGET=false
        elif [[ $line = "# Docker" ]]; then
                Command="docker pull" ; Skip=true ; Switch_WGET=false
        elif [[ $line = "# Python" ]]; then
                Command="pip3 install" ; Skip=true ; Switch_WGET=false
        elif [[ $line = "# Git" ]]; then
                Command="git clone" ; Skip=true ; mkdir -p $OPT_Path ; cd $OPT_Path ; Switch_WGET=false
	elif [[ $line = "# Wordlists" ]]; then
		Command="git clone" ; Skip=true ; mkdir -p /opt/wordlists ; cd /opt/wordlists ; Switch_WGET=false
	elif [[ $line = "# Wget" ]]; then
		Switch_WGET=true
        else
		if [ "$Skip" = false ] && [ ! "$line" = "" ]; then
			echo -e "-------------------------------------------------------------------------------\n\nDownload ${ORANGE}$line${NOCOLOR}"
			if [ "$Switch_WGET" = false ]; then
				eval "$Command $line"
			else
				FILE_NAME=$(echo "$line" | cut -d" " -f2)
				FILE=$(echo $line | cut -d" " -f1)
				MODE=$(echo $line | cut -d" " -f3)
				if [ "$MODE" = "Executeable" ]; then
					mkdir -p $OPT_Path/$FILE_NAME ; cd $OPT_Path/$FILE_NAME
					wget $FILE -O $FILE_NAME
					chmod +x $FILE_NAME ; cd $OPT_Path
				elif [ "$MODE" = "Archive" ]; then
					wget --content-disposition $FILE
					FILE_NAME=$(curl -L --head -s $FILE | grep filename | cut -d "=" -f2)
					if [[ ${#FILE_NAME} -gt 0 ]]; then
						sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/zip.py $FILE_NAME $OPT_Path
					else
						sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/zip.py $FILE $OPT_Path
					fi
				fi
			fi
		fi
	fi
	Skip=false
done < $input

# Screen_Configuration
for i in $(ls /home | grep -v "lost+found") $(echo /root); do
        if [[ !($i = "/root") ]]; then
                PATH_SCREEN="/home/$i/.screenrc"
        else
                PATH_SCREEN="/root/.screenrc"
        fi
	cat <<EOF > $PATH_SCREEN
hardstatus on
hardstatus alwayslastline
hardstatus string "%{.bW}%-w%{.rW}%n %t%{-}%+w %=%{..G} %Y-%m-%d %c "
EOF
done

if [ $category_type = "pentest" ];  then
	# Git_Tools_Installation
	if [ -f "/opt/pentest_tools/PEASS-ng/metasploit/peass.rb" ]; then
		sudo cp /opt/pentest_tools/PEASS-ng/metasploit/peass.rb /usr/share/metasploit-framework/modules/post/multi/gather/
	fi
	if [ -f "/opt/pentest_tools/EyeWitness/Python/setup/setup.sh" ]; then
		sudo bash /opt/pentest_tools/EyeWitness/Python/setup/setup.sh
	fi
	if [ -d "/opt/pentest_tools/ssh_scan" ]; then
		cd /opt/pentest_tools/ssh_scan ; sudo gem install bundler ; sudo bundle install
	fi

	# Metasploit_Configuration
	sudo systemctl enable --now postgresql
	sudo msfdb init
fi

if [ $decision = "full" ]; then
	if [ $category_type = "pentest" ];  then
		ln -s $OPT_Path/Postman/app/Postman /usr/local/bin/postman
	fi
	if [[ -f $OPT_Path/$(ls $OPT_Path | grep setup-gui-x64) ]]; then
		sudo bash $OPT_Path/$(ls $OPT_Path | grep setup-gui-x64)
		for veracrypt_file in $(ls $OPT_Path | grep setup); do sudo rm -f $OPT_Path/$veracrypt_file; done
	fi
fi

if [[ $1 != "-s" ]]; then
	declare -a Array_HARDENING=("#Protecting_against_IP-Spoofing"
	"net.ipv4.conf.default.rp_filter=1"
	"net.ipv4.conf.all.rp_filter=1"
	"#Protecting_against_SYN_flood_attacks"
	"net.ipv4.tcp_syncookies=1"
	"#Protecting_against_time-wait-assassination"
	"net.ipv4.tcp_rfc1337=1"
	"#Protecting_against_MITM"
	"net.ipv4.conf.all.accept_redirects=0"
	"net.ipv4.conf.default.accept_redirects=0"
	"net.ipv4.conf.all.secure_redirects=0"
	"net.ipv4.conf.default.secure_redirects=0"
	"net.ipv6.conf.all.accept_redirects=0"
	"net.ipv6.conf.default.accept_redirects=0"
	"net.ipv4.conf.all.send_redirects=0"
	"net.ipv4.conf.default.send_redirects=0"
	"#Protecting_against_MITM"
	"net.ipv4.icmp_echo_ignore_all=1"
	"#Protecting_against_ICMP_Smurf_Attacks"
	"net.ipv4.conf.all.accept_source_route=0"
	"#Protecting_against_MITM_-_Redirecting_network_traffic"
	"net.ipv4.conf.default.accept_source_route=0"
	"net.ipv6.conf.all.accept_source_route=0"
	"net.ipv6.conf.default.accept_source_route=0"
	"net.ipv6.conf.all.accept_ra=0"
	"#Protecting_against_MITM_-_ipv6"
	"net.ipv6.conf.default.accept_ra=0"
	"#Protecting_against_TCP-SACK_Exploits"
	"net.ipv4.tcp_sack=0"
	"net.ipv4.tcp_dsack=0"
	"net.ipv4.tcp_fack=0"
	"#Kernel_self-protection"
	"kernel.kptr_restrict=2"
	"kernel.dmesg_restrict=1"
	"kernel.printk=3 3 3 3"
	"kernel.unprivileged_bpf_disabled=1"
	"vsyscall=none"
	"debugfs=off"
	"oops=panic"
	"net.core.bpf_jit_harden=2"
	"dev.tty.ldisc_autoload=0"
	"vm.unprivileged_userfaultfd=0"
	"kernel.kexec_load_disabled=1"
	"kernel.sysrq=4"
	"kernel.unprivileged_userns_clone=0"
	"kernel.perf_event_paranoid=3")
	for i in ${Array_HARDENING[@]}; do
		if [[ $i =~ "#" ]]; then
			LEN_SYSCTL=$(cat /etc/sysctl.conf | grep $i)
		else
	        	LEN_SYSCTL=$(cat /etc/sysctl.conf | grep -v '#' | grep $i)
		fi
        	if [[ !${#LEN_SYSCTL} -gt 0 ]]; then
			cat <<EOF >> /etc/sysctl.conf
$i
EOF
		fi
	done
	sudo sysctl --system
	# Firewall_Configuration
	if [ -f /etc/iptables/rules.v4 ]; then
		sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/filter.py
		sudo sed -i '/# Commit all changes/d' /etc/iptables/rules.v4
		sudo sed -i '/COMMIT/d' /etc/iptables/rules.v4
		sudo sed -i '/# Completed on/d' /etc/iptables/rules.v4
		cat <<EOF >> /etc/iptables/rules.v4
# Commit all changes
COMMIT
# Completed on $(date +'%m/%d/%Y %H:%M:%S')
EOF
	else
		cat <<EOF > /etc/iptables/rules.v4
# /etc/iptables/rules.v4:
# Generated by ip6tables-save on $(date +'%m/%d/%Y %H:%M:%S')
*filter
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
# Allow established, related and localhost traffic
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A INPUT -s 127.0.0.0/8 -j ACCEPT
# Allow incoming PING
-A INPUT -p icmp --icmp-type 8 -s 0/0 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT -m comment --comment "ACCEPT icmp echo (ping) requests"
# Allow incoming SSH connections with protection
-A INPUT -p tcp --dport 22 -j ACCEPT -m comment --comment "ACCEPT ssh connections to port 22/tcp"
-A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 600 --hitcount 10 -j DROP
# Other stuff like reverse-shell access et alii
# -A INPUT -i eth2 -s 123.123.123.123 -p tcp --dport 4444 -j ACCEPT -m comment --comment "Reverse Shell 4444/tcp
# Commit all changes
COMMIT
# Completed on $(date +'%m/%d/%Y %H:%M:%S')
EOF
	fi

	if [ -f /etc/iptables/rules.v6 ]; then
		sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/filter.py
		sudo sed -i '/# Commit all changes/d' /etc/iptables/rules.v6
		sudo sed -i '/COMMIT/d' /etc/iptables/rules.v6
		sudo sed -i '/# Completed on/d' /etc/iptables/rules.v6
		cat <<EOF >> /etc/iptables/rules.v6
# Commit all changes
COMMIT
# Completed on $(date +'%m/%d/%Y %H:%M:%S')
EOF
	else
		cat <<EOF > /etc/iptables/rules.v6
# /etc/iptables/rules.v6:
# Generated by ip6tables-save on $(date +'%m/%d/%Y %H:%M:%S')
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
# Completed on $(date +'%m/%d/%Y %H:%M:%S')
EOF
	fi
	sudo chmod 0600 /etc/iptables/*
	sudo systemctl enable --now netfilter-persistent.service

	# SSH_Configuration
	sudo sed -i "s/#ListenAddress 0.0.0.0/ListenAddress $IP_INT:22/g" /etc/ssh/sshd_config
	sudo sed -i "s/#LogLevel INFO/LogLevel VERBOSE/g" /etc/ssh/sshd_config
	sudo sed -i "s/#MaxAuthTries 6/MaxAuthTries 6/g" /etc/ssh/sshd_config
	sudo sed -i "s/#UseDNS no/UseDNS no/g" /etc/ssh/sshd_config
	sudo sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
	sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
	cat <<EOF >> /etc/ssh/sshd_config

# Disable OS-Banner
DebianBanner no

EOF
	IFS=""
	for Cipher in ${Array_SSH_Ciphers[@]}; do
		if [[ ! $(cat /etc/ssh/sshd_config | grep -e $Cipher) ]]; then
			cat <<EOF >> /etc/ssh/sshd_config
$Cipher
EOF
		fi
	done
	sudo systemctl restart ssh.service
fi

# Docker_Standard_Images
if [[ $(cat $File_Path | grep nessus) ]]; then
	sudo docker run -d -p 127.0.0.1:8834:8834 --name nessus tenableofficial/nessus
fi
if [ $category_type = "pentest" ];  then
	if [[ $decision = "full" ]]; then
		echo -e "\n"; cat $Informational
	fi
fi
for i in $(ls $OPT_Path | grep -E ".tar|.bz2|.zip|.rar"); do rm -f $OPT_Path/$i; done
echo -e "\n---------------------------------------------------------------------------------\n                    ${ORANGE}The installation was successful! :)${NOCOLOR}"
