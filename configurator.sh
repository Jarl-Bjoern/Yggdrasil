#!/bin/bash
# Rainer Christian Bjoern Herold

# Variables
decision=""
IP_INT=127.0.0.1
FULL_PATH=$(readlink -f -- "$0")
SCRIPT_NAME=$(basename $BASH_SOURCE)
PATH_ALIAS=""
PATH_Install_Dir=""
PATH_SCREEN=""
PATH_VIM=""
PATH_ZSH=""
pentesting=""
Skip=false
Switch_IGNORE=false
Switch_License=false
Switch_Skip=false
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

declare -a Array_Filter_Download=("/usr/bin/veracrypt"
"/usr/bin/cargo"
"/usr/bin/rustc"
"/usr/bin/google-chrome"
"/opt/SmartBear/SoapUI"
"/opt/pentest_tools/jetbrains"
"/opt/pentest_tools/mitmproxy"
"/opt/pentest_tools/kerbrute")

declare -a Array_Filter_Git=("/opt/pentest_tools/Webscanner/SAP/pysap"
"/opt/pentest_tools/Webscanner/SAP/PyRFC"
"/opt/pentest_tools/Webscanner/SAP/SAP_GW_RCE_exploit"
"/opt/pentest_tools/Webscanner/SAP/SAP_RECON"
"/opt/pentest_tools/Webscanner/Drupal/drupwn"
"/opt/pentest_tools/Webscanner/Drupal/droopescan"
"/opt/pentest_tools/Webscanner/Drupal/CMSmap"
"/opt/pentest_tools/Webscanner/Drupal/ac-drupal"
"/opt/pentest_tools/Webscanner/Typo3/Typo3Scan"
"/opt/pentest_tools/Webscanner/Typo3/T3Scan"
"/opt/pentest_tools/Webscanner/Wordpress/wpscan"
"/opt/pentest_tools/Webscanner/Wordpress/wphunter"
"/opt/pentest_tools/Webscanner/Wordpress/Wordpresscan"
"/opt/pentest_tools/Webscanner/Wordpress/WPSeku"
"/opt/pentest_tools/Webscanner/Joomla/joomscan"
"/opt/pentest_tools/Webscanner/Joomla/joomlavs"
"/opt/pentest_tools/Webscanner/Moodle/moodlescan"
"/opt/pentest_tools/Webscanner/Moodle/badmoodle"
"/opt/pentest_tools/Webscanner/Moodle/mooscan"
"/opt/pentest_tools/Webscanner/Plone/plown"
"/opt/pentest_tools/Webscanner/Liferay/LiferayScan")

declare -a Array_Complete_Install=("${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Forensic/full.txt"
"${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Infrastructure/full.txt"
"${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/IOT/full.txt"
"${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Mobile/full.txt"
"${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Red_Teaming/full.txt"
"${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Web/full.txt")

declare -a Array_Pentesting=()
declare -a Array_Categories=()

# Color
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[1;33m'
NOCOLOR='\033[0m'

# Functions
function initials {
        echo "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀"
        echo "💀                                                      💀"
        echo "💀                       Yggdrasil                      💀"
        echo -e "💀                     Version ${CYAN}0.7g${NOCOLOR}                     💀"
        echo "💀           Rainer Christian Bjoern Herold             💀"
        echo "💀                                                      💀"
        echo -e "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀\n"
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
	echo -e "${CYAN}----------------------------------------------------------${NOCOLOR}"
	echo -e "${CYAN}|${NOCOLOR}                                                        ${CYAN}|${NOCOLOR}"
	if [ $1 = "category" ]; then
		echo -e "${CYAN}|${NOCOLOR} [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}    :   installation of both toolkits      ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${CYAN}2${NOCOLOR}] ${CYAN}custom${NOCOLOR}      :   installation of custom tools       ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${GREEN}3${NOCOLOR}] ${GREEN}forensic${NOCOLOR}    :   installation of forensic tools     ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${ORANGE}4${NOCOLOR}] ${ORANGE}pentest${NOCOLOR}     :   installation of pentest tools      ${CYAN}|${NOCOLOR}"
	elif [ $1 = "installation" ]; then
		echo -e "${CYAN}|${NOCOLOR} [${GREEN}1${NOCOLOR}]        ${GREEN}full${NOCOLOR}    : full installation (GUI)           ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${ORANGE}2${NOCOLOR}]        ${ORANGE}minimal${NOCOLOR} : minimal installation (CLI)        ${CYAN}|${NOCOLOR}"
	elif [ $1 = "pentesting_category" ]; then
		echo -e "${CYAN}|${NOCOLOR} [${GREEN}1${NOCOLOR}] ${GREEN}infrastructure${NOCOLOR}  :   tools for infra pentesting     ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${ORANGE}2${NOCOLOR}] ${ORANGE}iot${NOCOLOR}             :   tools for iot pentesting       ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${BLUE}3${NOCOLOR}] ${BLUE}mobile${NOCOLOR}          :   tools for mobile pentesting    ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${RED}4${NOCOLOR}] ${RED}red_teaming${NOCOLOR}     :   tools for red teaming          ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${CYAN}5${NOCOLOR}] ${CYAN}web${NOCOLOR}             :   tools for web pentesting       ${CYAN}|${NOCOLOR}"
	elif [ $1 = "hardening" ]; then
		echo -e "${CYAN}|${NOCOLOR} [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}    :   complete configuration      ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${CYAN}2${NOCOLOR}] ${CYAN}Firewall${NOCOLOR}      :   firewall hardening       ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${GREEN}3${NOCOLOR}] ${GREEN}Sysctl (OS)${NOCOLOR}    :   sysctl hardening     ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR} [${ORANGE}4${NOCOLOR}] ${ORANGE}SSH${NOCOLOR}     :   SSH hardening      ${CYAN}|${NOCOLOR}"
	fi
	echo -e "${CYAN}|${NOCOLOR}                                                        ${CYAN}|${NOCOLOR}"
	echo -e "${CYAN}----------------------------------------------------------${NOCOLOR}\n"
}

function File_Installer() {
	input=$1
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
			Command="git clone" ; Skip=true ; mkdir -p $2 ; cd $2 ; Switch_WGET=false
		elif [[ $line = "# Gem" ]]; then
			Command="gem install" ; Skip=true ; Switch_WGET=false
		elif [[ $line = "# Go" ]]; then
			Command="go get" ; Skip=true ; Switch_WGET=false
		elif [[ $line = "# Wordlists" ]]; then
			Command="git clone" ; Skip=true ; mkdir -p /opt/wordlists ; cd /opt/wordlists ; Switch_WGET=false
		elif [[ $line = "# Wget" ]]; then
			Switch_WGET=true
		else
			if [ "$Skip" = false ] && [ ! "$line" = "" ]; then
				echo -e "${CYAN}-------------------------------------------------------------------------------${NOCOLOR}\n\nDownload ${ORANGE}$line${NOCOLOR}"				
				if [ "$Switch_WGET" = false ]; then
					if [[ $line =~ "github" ]]; then
						for CHECK_GIT in ${Array_Filter_Git}; do
							if [[ $CHECK_GIT =~ $(echo $line | cut -d "/" -f5) ]]; then
								if [[ $(ls $CHECK_GIT) ]]; then
									Switch_IGNORE=true
									break
								fi
							fi
						done
					if [ "$Switch_Skip" = true ]; then
						if [[ $line =~ "iptables-persistent" || $line =~ "netfilter-persistent" || $line =~ "charon" || $line =~ "strongswan" || $line =~ "openconnect" || $line =~ "opensc" ]]; then
							echo "$line was skipped"
						else
							if [[ $Switch_IGNORE = false ]]; then
								eval "$Command $line"
							else
								echo "$line already exists."
							fi
						fi
					else
						if [[ $Switch_IGNORE = false ]]; then
							eval "$Command $line"
						else
							echo "$line already exists."
						fi
					fi
				else
					FILE=$(echo $line | cut -d" " -f1)
					FILE_NAME=$(echo "$line" | cut -d" " -f2)
					for CHECK_FILE in ${Array_Filter_Download[@]}; do
						if [[ $CHECK_FILE =~ $FILE_NAME ]]; then
							if [[ $(ls $CHECK_FILE) ]]; then
								Switch_IGNORE=true
								break
							fi
						fi
					done
					if [[ $Switch_IGNORE = false ]]; then
						MODE=$(echo $line | cut -d" " -f3)
						mkdir -p $2 ; cd $2
						if [ "$MODE" = "Executeable" ]; then
							mkdir -p $2/$FILE_NAME ; cd $2/$FILE_NAME
							wget $FILE -O $FILE_NAME
							chmod +x $FILE_NAME ; cd $2
						elif [ "$MODE" = "Archive" ]; then
							wget --content-disposition $FILE
							FILE_NAME=$(curl -L --head -s $FILE | grep filename | cut -d "=" -f2)
							if [[ ${#FILE_NAME} -gt 0 ]]; then
								sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/zip.py $FILE_NAME $2
							else
								sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/zip.py $FILE $2
							fi
						elif [ "$MODE" = "Installer" ]; then
							wget --content-disposition $FILE
							FILE_NAME=$(curl -L --head -s $FILE | grep filename | cut -d "=" -f2)
							if [[ $FILE_NAME =~ "rustup" ]]; then
								sudo bash $2/$(echo $FILE_NAME | cut -d '"' -f2) -y
							else
								sudo bash $2/$(echo $FILE_NAME | cut -d '"' -f2)
							fi
						elif [ "$MODE" = "DPKG" ]; then
							FILE_NAME=$(curl -L --head -s $FILE | grep filename | cut -d "=" -f2)
							if [[ ${#FILE_NAME} -gt 0 ]]; then
								wget --content-disposition $FILE
								sudo dpkg -i $2/$(echo $FILE_NAME | cut -d '"' -f2)
							else
								FILE_NAME=$(echo "$line" | cut -d" " -f2)
								wget $FILE -O $FILE_NAME.deb
								sudo dpkg -i $2/$(echo $FILE_NAME | cut -d '"' -f2).deb
							fi

						fi
					else
						echo "$FILE_NAME already exists."
					fi
				fi
			fi
		fi
		Skip=false
		Switch_IGNORE=false
		sleep 0.15
	done < $input
}

function Check_Parameter() {
	LEN_ARGV=$(wc -c <<< "$1")
	if [[ $1 == "-s" ]]; then
		Switch_Skip=true
	elif [[ $1 == "-aL" ]]; then
		Switch_License=true
	elif [[ $LEN_ARGV -gt 2 ]]; then
		if [[ -d $1 ]]; then
			PATH_Install_Dir=$1
		fi
	fi
}

# Checking_Arguments
if [ $1 ]; then
	Check_Parameter $1
fi

if [ $2 ]; then
	Check_Parameter $2
fi

if [ $3 ]; then
	Check_Parameter $3
fi

# Category
header "category"
read -p "Your Choice: " category_type
if [[ $category_type = "forensic" || $category_type = "3" ]]; then
	Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Forensic"
	OPT_Path="/opt/forensic_tools"
elif [[ $category_type = "pentest" || $category_type = "4" ]];  then
	OPT_Path="/opt/pentest_tools"
	if [[ $(cat /etc/hostname) == "kali" ]]; then
		sed -i s/'kali/pentest-kali'/g /etc/hostname
	fi
	sed -i s/'127.0.1.1	kali/127.0.1.1	pentest-kali'/g /etc/hosts
	header "pentesting_category"
	read -p "Your Choice: " pentesting
	if [[ $pentesting =~ "," ]]; then
        	readarray -td, Array_Pentesting <<< "$pentesting", declare -p Array_Pentesting
		for testing_category in ${Array_Pentesting[@]}; do
                        if [[ $testing_category = "infrastructure" || $testing_category = "1" ]]; then
				Array_Categories+=("${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Infrastructure")
			elif [[ $testing_category = "iot" || $testing_category = "2" ]];  then
				Array_Categories+=("${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/IOT")
			elif [[ $testing_category = "mobile" || $testing_category = "3" ]];  then
				Array_Categories+=("${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Mobile")
			elif [[ $testing_category = "red_teaming" || $testing_category = "4" ]];  then
				Array_Categories+=("${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Red_Teaming")
			elif [[ $testing_category = "web" || $testing_category = "5" ]];  then
				Array_Categories+=("${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Web")
			else
				echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
			fi
                done
	else
		if [[ $pentesting = "infrastructure" || $pentesting = "1" ]]; then
			Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Infrastructure"
		elif [[ $pentesting = "iot" || $pentesting = "2" ]];  then
			Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/IOT"
		elif [[ $pentesting = "mobile" || $pentesting = "3" ]];  then
			Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Mobile"
		elif [[ $pentesting = "red_teaming" || $pentesting = "4" ]];  then
			Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Red_Teaming"
		elif [[ $pentesting = "web" || $pentesting = "5" ]];  then
			Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Web"
		else
			echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
		fi
	fi
elif [[ $category_type = "complete" || $category_type = "1" ]]; then
	if [[ $(cat /etc/hostname) == "kali" ]]; then
		sed -i s/'kali/pentest-kali'/g /etc/hostname
	fi
	sed -i s/'127.0.1.1	kali/127.0.1.1	pentest-kali'/g /etc/hosts
elif [[ $category_type = "custom" || $category_type = "2" ]]; then
	Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Custom"
else
        echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
fi

# Installation_Type
if [[ $category_type = "custom" || $category_type = "2" ]]; then
	File_Path="${Path_Way}/install.txt"
elif [[ $category_type = "complete" || $category_type = "1" ]]; then
	decision="0"
else
	if [[ ${#Array_Categories} -gt 0 ]]; then
		Path_Way="${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/Pentest/Infrastructure"
		File_Path="${Path_Way}/full.txt"
		Informational="${FULL_PATH::-${#SCRIPT_NAME}}/Information/info.txt"
	else
		if [[ $pentesting = "iot" || $pentesting = "2" || $pentesting = "mobile" || $pentesting = "3" || $pentesting = "red_teaming" || $pentesting = "4" || $pentesting = "web" || $pentesting = "5" ]]; then
			File_Path="${Path_Way}/full.txt"
			decision="full"
			Informational="${FULL_PATH::-${#SCRIPT_NAME}}/Information/info.txt"
		else
			header "installation"
			read -p "Your Choice: " decision
			if [[ $decision = "full" || $decision = "1" ]]; then
				File_Path="${Path_Way}/full.txt"
				if [[ $category_type = "pentest" || $category_type = "4" ]];  then
					Informational="${FULL_PATH::-${#SCRIPT_NAME}}/Information/info.txt"
				fi
			elif [[ $decision = "minimal" || $decision = "2" ]];  then
				File_Path="${Path_Way}/minimal.txt"
			else
				echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
			fi
		fi
	fi
fi

# SSH_IP_Address
clearing
if [[ $Switch_Skip != true ]]; then
	NIC=$(ip a | grep "state UP" | cut -d " " -f2 | grep -v -E "lo|docker|veth")
	IP=$(ifconfig | grep -E "inet|inet6" | cut -d " " -f10 | grep -v -E "127.0.0.1|172.17.0.1|::1" | sort -u)
	readarray -t ARRAY_NIC <<< "$NIC" ; readarray -t ARRAY_IP <<< "$IP"

	echo -e "\n           Please select an IP address to be used\n                   for SSH configuration"
	echo -e "${CYAN}----------------------------------------------------------${NOCOLOR}\n"
	n=0
	while [[ n -le ${#ARRAY_NIC[@]} ]]; do
                echo -e "    " ${ORANGE}${ARRAY_NIC[n]}${NOCOLOR} "\n       - "  ${ARRAY_IP[n]} "(IPv4)\n       - " ${ARRAY_IP[$((n + 1))]} "(IPv6)"
                n=$((n + 2))
	done
	echo -e "${CYAN}----------------------------------------------------------${NOCOLOR}\n"
	read -p "Your Choice: " IP_TEMP
	if [[ ${#IP_TEMP} -gt 0 ]]; then
		LEN_CHECK=$(ip a | grep "$IP_TEMP")
		if [[ ${#LEN_CHECK} -gt 0 ]] && [[ ${IP_TEMP} = *"."* ]]; then
			IP_INT=$IP_TEMP
		elif [[ ${#LEN_CHECK} -gt 0 ]] && [[ ${IP_TEMP} = *":"* ]]; then
			IP_INT="[$IP_TEMP]"
		else
			echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
		fi
		clearing
	else
		echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
	fi
fi

# Basic_Configuration
if [[ $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d '"' -f2) =~ "Kali" ]]; then
	sudo sed -i "s#deb http://http.kali.org/kali kali-rolling main contrib non-free#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free#g" /etc/apt/sources.list
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

# Standard_Installation
if [[ $Switch_Skip != true ]]; then
	echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
	echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
fi
if [[ $category_type != "custom" || $category_type != "2" ]]; then
	File_Installer "${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/General/standard.txt" $OPT_Path
	if [[ $decision = "full" || $decision = "1" || $category_type = "complete" || $category_type = "1" ]]; then
		File_Installer "${FULL_PATH::-${#SCRIPT_NAME}}/Config/Linux/General/gui.txt" $OPT_Path
	fi
fi

# Tool_Installation
if [[ $category_type = "complete" || $category_type = "1" ]]; then
	for i in ${Array_Complete_Install[@]}; do
		if [[ $i =~ "Forensic" ]]; then
			File_Installer $i "/opt/forensic_tools"
		else
	        	File_Installer $i "/opt/pentest_tools"
		fi
	done
else
	if [[ ${#Array_Categories} -gt 0 ]]; then
		for i in ${Array_Categories[@]}; do
			File_Installer "${i}/full.txt" "/opt/pentest_tools"
		done
	else
		File_Installer $File_Path $OPT_Path
	fi
fi

# Path_Filtering
for i in $(ls /home | grep -v "lost+found") $(echo /root); do
        if [[ !($i = "/root") ]]; then
                PATH_SCREEN="/home/$i/.screenrc"
		PATH_ALIAS="/home/$i/.bash_aliases"
		PATH_VIM="/home/$i/.vimrc"
		PATH_ZSH="/home/$i/.zshrc"
        else
                PATH_SCREEN="/root/.screenrc"
		PATH_ALIAS="/root/.bash_aliases"
		PATH_VIM="/root/.vimrc"
		PATH_ZSH="/root/.zshrc"
        fi

	# ZSH_Configuration
	sudo sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" $PATH_ZSH
	if [[ !$(cat $PATH_ZSH | grep "hist_ignore_all_dups") ]]; then
		cat <<EOF >> $PATH_ZSH
setopt hist_ignore_all_dups
EOF
	fi

	# Screen_Configuration (Thx to @HomeSen)
	cat <<EOF > $PATH_SCREEN
hardstatus on
hardstatus alwayslastline
hardstatus string "%{.bW}%-w%{.rW}%n %t%{-}%+w %=%{..G} %Y-%m-%d %c "
EOF

	# Vim_Configuration (Thx to @HomeSen)
	cat <<EOF > $PATH_VIM
syntax on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

"set showcmd            " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
"set smartcase          " Do smart case matching
"set incsearch          " Incremental search
"set autowrite          " Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=              " Enable mouse usage (all modes)

set number
set background=dark

" Custom status line
set laststatus=2
set statusline=%F
set statusline+=\ 
set statusline+=%r
set statusline+=\ 
set statusline+=%y
set statusline+=%=
set statusline+=pos:
set statusline+=\ 
set statusline+=%c
set statusline+=\ 
set statusline+=[\ 
set statusline+=%l
set statusline+=\ /\ 
set statusline+=%L
set statusline+=\ ]
set statusline+=\ 
set statusline+=%p%%
EOF

	# Alias_Configuration (Thx to @HomeSen)
	cat <<EOF > $PATH_ALIAS
alias la='ls -lha --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'

alias ffs='sudo $(history -p !!)'
alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'

function b64() { echo $1 | base64 -d | xxd; }
EOF
done

if [[ $category_type = "pentest" || $category_type = "4" || $category_type = "complete" || $category_type = "1" ]];  then
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
	if [ -d "/opt/pentest_tools/socketcand" ]; then
		cd /opt/pentest_tools/socketcand ; sudo bash autogen.sh ; sudo ./configure ; sudo make ; sudo make install
	fi
	if [ -d "/opt/pentest_tools/chisel" ]; then
		cd /opt/pentest_tools/chisel ; sudo go get ; sudo go build
	fi
	if [ -f "/opt/pentest_tools/$(ls /opt/pentest_tools | grep SoapUI)" ]; then
		sudo bash /opt/pentest_tools/$(ls /opt/pentest_tools | grep SoapUI)
	fi
	if [ -d "/opt/pentest_tools/Responder" ]; then
		pip3 install -r /opt/pentest_tools/Responder/requirements.txt
	fi
	if [ -f "/opt/pentest_tools/mitmdump" ]; then
		cd /opt/pentest_tools ; mv mitmproxy mitmproxy.sh ; sudo mkdir -p /opt/pentest_tools/mitmproxy ; mv mitmproxy.sh mitmdump mitmweb mitmproxy/ ; cd mitmproxy/ ; mv mitmproxy.sh mitmproxy
	fi
	if [[ $(ls /opt/pentest_tools | grep -E "pysap|PyRFC|SAP_GW_RCE_exploit|SAP_RECON") ]]; then
		cd /opt/pentest_tools ; sudo mkdir -p /opt/pentest_tools/Webscanner/SAP ; mv pysap PyRFC SAP_GW_RCE_exploit SAP_RECON /opt/pentest_tools/Webscanner/SAP
	fi
	if [[ $(ls /opt/pentest_tools | grep -E "drupwn|droopescan|CMSmap|ac-drupal") ]]; then
		cd /opt/pentest_tools ; sudo mkdir -p /opt/pentest_tools/Webscanner/Drupal ; mv drupwn droopescan CMSmap ac-drupal /opt/pentest_tools/Webscanner/Drupal
	fi
	if [[ $(ls /opt/pentest_tools | grep -E "Typo3Scan|T3Scan") ]]; then
		cd /opt/pentest_tools ; sudo mkdir -p /opt/pentest_tools/Webscanner/Typo3 ; mv Typo3Scan T3Scan /opt/pentest_tools/Webscanner/Typo3
	fi
	if [[ $(ls /opt/pentest_tools | grep -E "wpscan|wphunter|WPSeku|Wordpresscan") ]]; then
		cd /opt/pentest_tools ; sudo mkdir -p /opt/pentest_tools/Webscanner/Wordpress ; mv wpscan wphunter Wordpresscan WPSeku /opt/pentest_tools/Webscanner/Wordpress
	fi
	if [[ $(ls /opt/pentest_tools | grep -E "joomscan|joomlavs") ]]; then
		cd /opt/pentest_tools ; sudo mkdir -p /opt/pentest_tools/Webscanner/Joomla ; mv joomscan joomlavs /opt/pentest_tools/Webscanner/Joomla
	fi
	if [[ $(ls /opt/pentest_tools | grep -E "moodlescan|mooscan|badmoodle") ]]; then
		cd /opt/pentest_tools ; sudo mkdir -p /opt/pentest_tools/Webscanner/Moodle ; mv moodlescan badmoodle mooscan /opt/pentest_tools/Webscanner/Moodle
	fi
	if [[ -d "/opt/pentest_tools/plown" ]]; then
		cd /opt/pentest_tools ; sudo mkdir -p /opt/pentest_tools/Webscanner/Plone ; mv plown /opt/pentest_tools/Webscanner/Plone
	fi
	if [[ -d "/opt/pentest_tools/LiferayScan" ]]; then
		cd /opt/pentest_tools ; sudo mkdir -p /opt/pentest_tools/Webscanner/Liferay ; mv LiferayScan /opt/pentest_tools/Webscanner/Liferay
	fi

	# Metasploit_Configuration
	sudo systemctl enable --now postgresql
	sudo msfdb init
fi

if [[ $decision = "full" || $decision = "1" || $category_type = "complete" || $category_type = "1" ]]; then
	if [[ $category_type = "pentest" || $category_type = "4" ]];  then
		ln -s $OPT_Path/Postman/app/Postman /usr/local/bin/postman
	fi
	if [[ -f $OPT_Path/$(ls $OPT_Path | grep setup-gui-x64) ]]; then
		if [[ $Switch_License ]]; then
			sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/auto.py Veracrypt $OPT_Path/$(ls $OPT_Path | grep setup-gui-x64)
		else
			sudo bash ${FULL_PATH::-${#SCRIPT_NAME}}/$OPT_Path/$(ls $OPT_Path | grep setup-gui-x64)
		fi
		for veracrypt_file in $(ls $OPT_Path | grep setup); do sudo rm -f $OPT_Path/$veracrypt_file; done
	fi
	if [ -d "/opt/pentest_tools/$(ls /opt/pentest_tools | grep jetbrains)" ]; then
		TEMP_PATH_JET=/opt/pentest_tools/$(ls /opt/pentest_tools | grep jetbrains)
		$TEMP_PATH_JET/jetbrains-toolbox ; sleep 10
	fi
	if [[ ${#PATH_Install_Dir} -gt 1 ]]; then
		sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/install.py $PATH_Install_Dir
	fi
fi

if [[ $Switch_Skip != true ]]; then
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
		sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/filter.py
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
# Generated by ip4tables-save on $(date +'%m/%d/%Y %H:%M:%S')
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
		sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/filter.py
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

# Unpacking_Rockyou
sudo gunzip /usr/share/wordlists/rockyou.txt.gz

# Linking_Local_Wordlists
ln -s /usr/share/wordlists /opt/wordlists/kali_wordlists

# Docker_Standard_Images
if [[ $(cat $File_Path | grep nessus) ]]; then
	if [[ $(docker ps -a | grep nessus) ]]; then
		NESSUS_DOCKER_TEMP=$(docker ps -a | grep "nessus" | cut -d " " -f1)
		docker stop $NESSUS_DOCKER_TEMP ; sleep 1 ; docker rm $NESSUS_DOCKER_TEMP
	fi
	sudo docker run -d -p 127.0.0.1:8834:8834 --name nessus tenableofficial/nessus
fi
if [[ $category_type = "pentest" || $category_type = "4"  ]];  then
	if [[ $decision = "full" || $decision = "1"  ]]; then
		echo -e "\n"; cat $Informational
	fi
fi
if [[ $category_type = "complete" || $category_type = "1" ]]; then
	sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/clean.py /opt/forensic_tools
	sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/clean.py /opt/pentest_tools
else
	sudo python3 ${FULL_PATH::-${#SCRIPT_NAME}}/Python/clean.py $OPT_Path
fi
echo -e "\n---------------------------------------------------------------------------------\n                    ${ORANGE}The installation was successful! :)${NOCOLOR}"
