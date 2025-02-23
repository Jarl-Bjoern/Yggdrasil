#!/bin/bash
# Rainer Christian Bjoern Herold

# Variables
decision=""
HOST_Pentest="pentest-kali"
IP_INT="127.0.0.1"
TEMP_PATH=$(readlink -f -- "$0")
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
FULL_PATH=${TEMP_PATH::-${#SCRIPT_NAME}-21}
OLDIFS="$IFS"
OPT_Path=""
PATH_ALIAS=""
PATH_Install_Dir=""
PATH_SCREEN=""
PATH_VIM=""
PATH_WORKSPACE=""
PATH_ZSH=""
pentesting=""
Show_Error_Message=false
Shredding_DAYS=""
Skip=false
SMB_Share_Name=""
SMB_Share_Path=""
SMB_Valid_Users=""
SMB_IP_Addresses=""
SMB_Hosts=""
Switch_APACHE=false
Switch_BloodHound=false
Switch_BRANCH=false
Switch_Cargo=false
Switch_CRON=false
Switch_CUSTOM_CONFIGS=false
Switch_Firewall=false
#Switch_FTP=false
Switch_GO=false
Switch_Hardening=false
Switch_IGNORE=false
Switch_License=false
Switch_NGINX=false
Switch_NEOVIM=false
Switch_REPO=false
Switch_SCREENRC=false
Switch_SCREENRC_HOMESEN=false
Switch_SCREENRC_BJOERN=false
Switch_SHREDDER=false
Switch_Skip_Configs=false
Switch_Skip_Hardening=false
Switch_Skip_Basic_Installation=false
Switch_Skip_Installation=false
Switch_Skip_URLS=false
Switch_SMB=false
#Switch_SQUID=false
Switch_SSH=false
Switch_SYSTEMD=false
Switch_TMUX=false
Switch_UPDATES=false
Switch_URL=true
Switch_Verbose=false
Switch_VIM_CONFIG=false
Switch_VIM_HOMESEN=false
Switch_VIM_NAYANINGALOO=false
Switch_WGET=false
TEMP_GIT_PATH=""
TEMP_WGET_PATH=""

# Arrays
declare -a Array_Categories=()
declare -a Array_Cargo_Updater=()
declare -a Array_Filter_Download=()

declare -a Array_Filter_Git=("/opt/pentest_tools/Webscanner/SAP/pysap"
"/opt/pentest_tools/Webscanner/SAP/PyRFC"
"/opt/pentest_tools/Webscanner/SAP/SAP_GW_RCE_exploit"
"/opt/pentest_tools/Webscanner/SAP/SAP_RECON"
"/opt/pentest_tools/Webscanner/SAP/nmap-erpscan"
"/opt/pentest_tools/Webscanner/Drupal/drupwn"
"/opt/pentest_tools/Webscanner/Drupal/droopescan"
"/opt/pentest_tools/Webscanner/Drupal/CMSmap"
"/opt/pentest_tools/Webscanner/Drupal/ac-drupal"
"/opt/pentest_tools/Webscanner/Typo3/Typo3Scan"
"/opt/pentest_tools/Webscanner/Typo3/T3Scan"
"/opt/pentest_tools/Webscanner/Wordpress/wphunter"
"/opt/pentest_tools/Webscanner/Wordpress/Wordpresscan"
"/opt/pentest_tools/Webscanner/Wordpress/WPSeku"
"/opt/pentest_tools/Webscanner/Joomla/joomscan"
"/opt/pentest_tools/Webscanner/Joomla/joomlavs"
"/opt/pentest_tools/Webscanner/Moodle/moodlescan"
"/opt/pentest_tools/Webscanner/Moodle/badmoodle"
"/opt/pentest_tools/Webscanner/Moodle/mooscan"
"/opt/pentest_tools/Webscanner/Plone/plown"
"/opt/pentest_tools/Webscanner/Liferay/LiferayScan"
"/opt/pentest_tools/Proxy/chisel"
"/opt/pentest_tools/Proxy/mitm_relay"
"/opt/pentest_tools/SIP/viproy-voipkit"
"/opt/pentest_tools/SIP/SIPTools"
"/opt/pentest_tools/API/swagger-ui"
"/opt/pentest_tools/API/jwt_tool")

declare -a Array_GIT_Updater=()

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
"#Protecting_against_ICMP_Smurf_Attacks"
"net.ipv4.icmp_echo_ignore_all=1"
"#Protecting_against_MITM_-_Redirecting_network_traffic"
"net.ipv4.conf.all.accept_source_route=0"
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
"kernel.randomize_va_space=2"
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

declare -a Array_Pentesting=()

declare -a Array_SSH_Ciphers=("# Keyexchange algorithms"
"KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256,sntrup761x25519-sha512"
"# Host-key algorithms"
"HostKeyAlgorithms ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,pgp-sign-dss,x509v3-ecdsa-sha2-nistp256,x509v3-ecdsa-sha2-nistp384,x509v3-ecdsa-sha2-nistp521"
"# Encryption algorithms (ciphers)"
"Ciphers chacha20-poly1305,aes256-ctr,aes128-ctr"
"# Message authentication code (MAC) algorithms"
"MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com")

declare -a Array_URL=()

# Color
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[1;33m'
NORANGE='\033[0;33m'
PURPLE='\033[0;35m'
UNDERLINE='\033[0;4m'
NOCOLOR='\033[0m'

# Functions
function initials {
        echo "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀"
        echo -e "💀\t\t\t\t\t\t\t\t💀"
        echo -e "💀\t\t           ${UNDERLINE}Yggdrasil${NOCOLOR}\t\t\t\t💀"
        echo -e "💀\t\t\t  ${NORANGE}Version ${CYAN}0.9d${NOCOLOR}   \t\t\t💀"
        echo -e "💀\t\t${CYAN}Rainer Christian Bjoern Herold${NOCOLOR}\t\t\t💀"
        echo -e "💀\t\t\t\t\t\t\t\t💀"
        echo -e "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀\n\n"
}

function clearing {
        sleep 2 ; clear ; initials
}

function Change_Hostname {
        if [[ $(cat /etc/hostname) == "kali" ]]; then
                 sudo sed -i s/"kali/$1"/g /etc/hostname
        fi
        sudo sed -i s/"127.0.1.1	kali/127.0.1.1	$1"/g /etc/hosts
}

function header() {
        clear ; initials
        if [ "$1" = "category" ]; then
                echo -e "\n              Please choose between one category"
        elif [ "$1" = "installation" ]; then
                echo -e "\n           Please choose between one installation"
        fi
        echo -e "${CYAN}-----------------------------------------------------------------${NOCOLOR}"
        echo -e "${CYAN}|${NOCOLOR}                                                               ${CYAN}|${NOCOLOR}"
        if [ "$1" = "category" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}    :  installation of all         toolkits     ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${CYAN}2${NOCOLOR}] ${CYAN}custom${NOCOLOR}      :  installation of custom      tools        ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}3${NOCOLOR}] ${GREEN}forensic${NOCOLOR}    :  installation of forensic    tools        ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}4${NOCOLOR}] ${ORANGE}pentest${NOCOLOR}     :  installation of pentest     tools        ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${BLUE}5${NOCOLOR}] ${BLUE}hardening${NOCOLOR}   :  installation of hardening   tools        ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${PURPLE}6${NOCOLOR}] ${PURPLE}training${NOCOLOR}    :  installation of training    tools        ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR}   [${RED}7${NOCOLOR}] ${RED}red_teaming${NOCOLOR} :  installation of red teaming tools        ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR}   [${CYAN}8${NOCOLOR}] ${CYAN}development${NOCOLOR} :  installation of development tools        ${CYAN}|${NOCOLOR}"
  	elif [ "$1" = "forensic" ]; then
		echo -e "${CYAN}|${NOCOLOR}  [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}           :  installation of  all  toolkits     ${CYAN}|${NOCOLOR}"
	        echo -e "${CYAN}|${NOCOLOR}  [${CYAN}2${NOCOLOR}] ${CYAN}cloud${NOCOLOR}              :  tools for cloud  analysis          ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR}  [${GREEN}3${NOCOLOR}] ${GREEN}crypto${NOCOLOR}             :  tools for crypto analysis          ${CYAN}|${NOCOLOR}"
  		echo -e "${CYAN}|${NOCOLOR}  [${ORANGE}4${NOCOLOR}] ${ORANGE}infrastructure${NOCOLOR}     :  tools for infrastructure analysis  ${CYAN}|${NOCOLOR}"
    		echo -e "${CYAN}|${NOCOLOR}  [${BLUE}5${NOCOLOR}] ${BLUE}mobile${NOCOLOR}             :  tools for mobile forensics         ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "development" ]; then
		echo -e "${CYAN}|${NOCOLOR}  [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}             :  installation of  all  toolkits   ${CYAN}|${NOCOLOR}"
	        echo -e "${CYAN}|${NOCOLOR}  [${CYAN}2${NOCOLOR}] ${CYAN}source_code_analysis${NOCOLOR} :  tools for source code analysis   ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR}  [${GREEN}3${NOCOLOR}] ${GREEN}reverse_engineering${NOCOLOR}  :  tools for reverse  engineering   ${CYAN}|${NOCOLOR}"
  		echo -e "${CYAN}|${NOCOLOR}  [${ORANGE}4${NOCOLOR}] ${ORANGE}exploit_development${NOCOLOR}  :  tools for exploit  development   ${CYAN}|${NOCOLOR}"
    		echo -e "${CYAN}|${NOCOLOR}  [${BLUE}5${NOCOLOR}] ${BLUE}malware_development${NOCOLOR}  :  tools for malware  development   ${CYAN}|${NOCOLOR}"
  	elif [ "$1" = "hardening_category" ]; then
		echo -e "${CYAN}|${NOCOLOR}  [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}           :  installation of  all  toolkits     ${CYAN}|${NOCOLOR}"
	        echo -e "${CYAN}|${NOCOLOR}  [${CYAN}2${NOCOLOR}] ${CYAN}cloud${NOCOLOR}              :  tools for cloud  hardening         ${CYAN}|${NOCOLOR}"
  		echo -e "${CYAN}|${NOCOLOR}  [${GREEN}3${NOCOLOR}] ${GREEN}infrastructure${NOCOLOR}     :  tools for infrastructure hardening ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "installation" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}1${NOCOLOR}] ${GREEN}full${NOCOLOR}         :     full    installation (${GREEN}GUI${NOCOLOR})           ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}2${NOCOLOR}] ${ORANGE}minimal${NOCOLOR}      :     minimal installation (${ORANGE}CLI${NOCOLOR})           ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "pentesting_category" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}1${NOCOLOR}] ${GREEN}infrastructure${NOCOLOR}  :   tools for infra  pentesting         ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}2${NOCOLOR}] ${ORANGE}iot${NOCOLOR}             :   tools for iot    pentesting         ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${BLUE}3${NOCOLOR}] ${BLUE}mobile${NOCOLOR}          :   tools for mobile pentesting         ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${CYAN}4${NOCOLOR}] ${CYAN}web${NOCOLOR}             :   tools for web    pentesting         ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${PURPLE}5${NOCOLOR}] ${PURPLE}cloud${NOCOLOR}           :   tools for cloud  pentesting         ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "red_team" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}            :   complete configuration          ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR}   [${PURPLE}2${NOCOLOR}] ${PURPLE}active_directory${NOCOLOR}    :   tools for active directory      ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${CYAN}3${NOCOLOR}] ${CYAN}osint${NOCOLOR}               :   tools for osint                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}4${NOCOLOR}] ${GREEN}phishing${NOCOLOR}            :   tools for phishing              ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}5${NOCOLOR}] ${ORANGE}physical${NOCOLOR}            :   tools for physical tests        ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "hardening" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}         :   complete configuration             ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${CYAN}2${NOCOLOR}] ${CYAN}firewall${NOCOLOR}         :   firewall configuration             ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}3${NOCOLOR}] ${GREEN}sysctl${NOCOLOR}           :   sysctl   hardening                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}4${NOCOLOR}] ${ORANGE}ssh${NOCOLOR}              :   ssh      hardening                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${BLUE}5${NOCOLOR}] ${BLUE}apache${NOCOLOR}           :   apache   hardening                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${PURPLE}6${NOCOLOR}] ${PURPLE}nginx${NOCOLOR}            :   nginx    hardening                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${RED}7${NOCOLOR}] ${RED}smb${NOCOLOR}              :   smb      hardening                 ${CYAN}|${NOCOLOR}"
                #echo -e "${CYAN}|${NOCOLOR}   [${CYAN}8${NOCOLOR}] ${CYAN}ftp${NOCOLOR}           :   ftp   hardening                 ${CYAN}|${NOCOLOR}"
                #echo -e "${CYAN}|${NOCOLOR}   [${GREEN}9${NOCOLOR}] ${GREEN}squid${NOCOLOR}            :   squid    hardening                 ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "settings" ]; then
                echo -e "${CYAN}|${NOCOLOR}  [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}      :   complete configuration                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${CYAN}2${NOCOLOR}] ${CYAN}updates${NOCOLOR}       :   automated updates                      ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}                        (${CYAN}APT${RED}|${CYAN}Cargo${RED}|${CYAN}Docker${RED}|${CYAN}Git Packages${RED}|${CYAN}Pip${NOCOLOR})    ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${GREEN}3${NOCOLOR}] ${GREEN}alias${NOCOLOR}         :   custom configs (${GREEN}alias${RED}|${GREEN}.bashrc${RED}|${GREEN}.zshrc${NOCOLOR})  ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${ORANGE}4${NOCOLOR}] ${ORANGE}screenrc${NOCOLOR}      :   custom screenrc config                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${BLUE}5${NOCOLOR}] ${BLUE}vim${NOCOLOR}           :   custom vim config                      ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${PURPLE}6${NOCOLOR}] ${PURPLE}repo${NOCOLOR}          :   kali repository change                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${RED}7${NOCOLOR}] ${RED}shredder${NOCOLOR}      :   workspace file shredding script        ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}                        (${RED}after 90 days [${ORANGE}default${RED}]${NOCOLOR})              ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR}  [${CYAN}8${NOCOLOR}] ${CYAN}tmux${NOCOLOR}          :   custom tmux config                     ${CYAN}|${NOCOLOR}"
		#echo -e "${CYAN}|${NOCOLOR}  [${CYAN}9${NOCOLOR}] ${CYAN}neovim${NOCOLOR}          :   custom neovim config                     ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "task" ]; then
                echo -e "${CYAN}|${NOCOLOR}  [${RED}1${NOCOLOR}] ${RED}cronjob${NOCOLOR}      :   cronjob configuration                   ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${CYAN}2${NOCOLOR}] ${CYAN}timer${NOCOLOR}        :   systemd timer configuration             ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "vim" ]; then
                echo -e "${CYAN}|${NOCOLOR}  [${RED}1${NOCOLOR}] ${RED}homesen${NOCOLOR}       :   custom vim config ${RED}(@HomeSen)${NOCOLOR}           ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${CYAN}2${NOCOLOR}] ${CYAN}nayaningaloo${NOCOLOR}  :   custom vim config ${CYAN}(@nayaningaloo)${NOCOLOR}      ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "screenrc" ]; then
                echo -e "${CYAN}|${NOCOLOR}  [${RED}1${NOCOLOR}] ${RED}homesen${NOCOLOR}       :   custom screenrc config ${RED}(@HomeSen)${NOCOLOR}      ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}  [${CYAN}2${NOCOLOR}] ${CYAN}jarl-bjoern${NOCOLOR}   :   custom screenrc config ${CYAN}(@jarl-bjoern)${NOCOLOR}  ${CYAN}|${NOCOLOR}"
        fi
        echo -e "${CYAN}|${NOCOLOR}                                                               ${CYAN}|${NOCOLOR}"
        echo -e "${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
}

function Create_Filter_Array() {
        input=$1
        while IFS= read -r line
        do
		if [[ ! "$line" =~ "#" && ${#line} -gt 2 ]]; then
                        if [[ "$line" =~ "https://" && $(grep -o " " <<< "$line" | wc -c) -gt 2 ]]; then
                                TEMP_Filter=$(echo "$line" | awk '{print $2}' | tr -d '\r')
                        elif [[ "$line" =~ "https://" && $(grep -o " " <<< "$line" | wc -c) -eq 2 ]]; then
                                TEMP_Filter=$(echo "$line" | awk '{print $1}' | rev | cut -d '/' -f1 | rev | tr -d '\r')
                        elif [[ "$line" =~ "https://" && ! "$line" =~ " " ]]; then
                                TEMP_Filter=$(echo "$line" | rev | cut -d '/' -f1 | rev | tr -d '\r')
                        else
                                TEMP_Filter=$(echo "$line" | tr -d '\r')
                        fi

                        if [[ $(find "$OPT_Path" -maxdepth 2 -name "$TEMP_Filter" -type d ! -path "$OPT_Path" | head -n1) ]]; then
                                Array_Filter_Download+=($(find "$OPT_Path" -maxdepth 2 -name "$TEMP_Filter" -type d ! -path "$OPT_Path" | head -n1))
                        elif [[ $(find '/opt/wordlists' -maxdepth 2 -name "$TEMP_Filter" -type d ! -path '/opt/wordlists' | head -n1) ]]; then
                                Array_Filter_Download+=($(find '/opt/wordlists' -maxdepth 2 -name "$TEMP_Filter" -type d ! -path '/opt/wordlists' | head -n1))
                        elif [[ $(find '/opt/hashcat_rules' -maxdepth 2 -name "$TEMP_Filter" -type d ! -path '/opt/hashcat_rules' | head -n1) ]]; then
                                Array_Filter_Download+=($(find '/opt/hashcat_rules' -maxdepth 2 -name "$TEMP_Filter" -type d ! -path '/opt/hashcat_rules' | head -n1))
                        elif [[ $(which "$TEMP_Filter") ]]; then
                                Array_Filter_Download+=($(which "$TEMP_Filter"))
                        fi
   		fi
 	done < "$input"
}

function Check_For_Skip_Download() {
	Switch_Skip_Git_Download=false
	for Check in ${Array_Filter_Download[@]}; do
		if [[ "$Check" =~ "$OPT_Path" && "$1" =~ $(echo "$Check" | rev | cut -d '/' -f1 | rev | tr -d '\r') ]]; then
			Switch_Skip_Git_Download=true
  		elif [[ "$Check" =~ "/opt/wordlists" && "$1" =~ $(echo "$Check" | rev | cut -d '/' -f1 | rev | tr -d '\r')  ]]; then
			Switch_Skip_Git_Download=true
    		elif [[ "$Check" =~ "/opt/hashcat_rules" && "$1" =~ $(echo "$Check" | rev | cut -d '/' -f1 | rev | tr -d '\r')  ]]; then
			Switch_Skip_Git_Download=true
		fi

  		if [[ "$Switch_Skip_Git_Download" == true ]]; then
			break
    		fi
	done
}

function Automation_Config_Check() {
	input=$1
 	while IFS= read -r line
  	do
		if [[ "$line" =~ ":" ]]; then
			Head=$(echo "$line" | awk '{print $1}' | cut -d ':' -f1)
   			Function_Value=$(echo "$line" | awk '{print $2}')
      			if [[ "$Head" == "Main" ]]; then
				if [[ "$Function_Value" == "Pentest" || "$Function_Value" == "pentest" || "$Function_Value" == "4" ]]; then
					echo "UNDER CONSTRUCTION"
    				elif [[ "$Function_Value" == "Forensic" || "$Function_Value" == "forensic" || "$Function_Value" == "3" ]]; then
					echo "UNDER CONSTRUCTION"
 				fi
  			fi
		fi
   	done < "$input"
}

function Download_Commander() {
	if [[ $Switch_IGNORE = false ]]; then
		if [[ $Command =~ "apt" ]]; then
			SECOND_Command="$Command $line || (apt --fix-broken install -y && $Command $line)"
			if [[ $(which "$line") || "$(apt-cache policy $line | head -n2 | grep "[0-9]" | awk '{print $2}')" ]]; then
			    echo -e "${RED}$line${NOCOLOR} is already installed."
			else
			    eval "$SECOND_Command"
			fi
		elif [[ $Command =~ "git clone -b" ]]; then
			FILE_URL=$(echo "$line" | cut -d" " -f1)
			FILE_BRANCH=$(echo "$line" | cut -d" " -f2)
			Check_For_Skip_Download $FILE_URL
			if [[ "$Switch_Skip_Git_Download" == false ]]; then
				eval "$Command $FILE_BRANCH $FILE_URL"
    			else
				Tool_Name=$(echo "$line" | awk '{print $1}' | rev | cut -d '/' -f1 | rev | tr -d '\r')
       				echo -e "${RED}$Tool_Name${NOCOLOR} already exists." | tee -a "$FULL_PATH/yggdrasil.log"
    			fi
		elif [[ $Command =~ "cargo" ]]; then
			eval "$Command $line" || source "$HOME/.cargo/env" && eval "$Command $line"
		else
			Check_For_Skip_Download $line
			if [[ "$Switch_Skip_Git_Download" == false ]]; then
				eval "$Command $line"
    			else
				Tool_Name=$(echo "$line" | rev | cut -d '/' -f1 | rev | tr -d '\r')
       				echo -e "${RED}$Tool_Name${NOCOLOR} already exists." | tee -a "$FULL_PATH/yggdrasil.log"
    			fi

			if [[ "$Command" =~ "git clone" && "$Switch_GO" == true ]]; then
				Temp_File_Name=$(echo "$line" | rev | cut -d '/' -f1 | rev | tr -d '\r')
				Temp_PATH_Switcher=$(find "$OPT_Path" -maxdepth 2 -name "$Temp_File_Name" -type d ! -path "$OPT_Path" | head -n1)
				cd $Temp_PATH_Switcher ; go install ; cd ..
			fi
		fi
		Logger "$Command" "$line"
	else
 		if [[ "$line" =~ "https://" ]]; then
			Tool_Name=$(echo "$line" | rev | cut -d '/' -f1 | rev | tr -d '\r')
   		else
     			Tool_Name="$line"
		fi
		echo -e "${RED}$Tool_Name${NOCOLOR} already exists." | tee -a "$FULL_PATH/yggdrasil.log"
	fi
}

function File_Installer() {
        function Logger() {
                if [[ $1 =~ "apt" ]]; then
                        if [[ ! $(apt-cache policy "$2" | grep "Installed:") =~ (none) || ! $(apt-cache policy "$2" | grep "Installiert:") =~ (keine) ]]; then
                                echo "$2 was successfully installed." >> "$FULL_PATH/yggdrasil.log"
                        else
                                echo "$2 was not installed." >> "$FULL_PATH/yggdrasil.log"
                        fi
                elif [[ $1 =~ "cargo" ]]; then
                        if cargo install --list | grep -q "$2"; then
                                echo "$2 was successfully installed." >> "$FULL_PATH/yggdrasil.log"
                        else
                                echo "$2 was not installed." >> "$FULL_PATH/yggdrasil.log"
                        fi
                        Array_Cargo_Updater+=("$2")
                elif [[ $1 =~ "docker" ]]; then
                        if docker images | grep -q "$2"; then
                                echo "$2 was successfully installed." >> "$FULL_PATH/yggdrasil.log"
                        else
                                echo "$2 was not installed." >> "$FULL_PATH/yggdrasil.log"
                        fi
                elif [[ $1 =~ "gem" ]]; then
                        if gem list | grep -q "$2"; then
                                echo "$2 was successfully installed." >> "$FULL_PATH/yggdrasil.log"
                        else
                                echo "$2 was not installed." >> "$FULL_PATH/yggdrasil.log"
                        fi
                elif [[ $1 =~ "git" ]]; then
                        if find "$OPT_Path" -maxdepth 1 ! -path "$OPT_Path" | grep -q "$(echo "$2" | rev | cut -d '/' -f1 | rev)"; then
                                echo "$2 was successfully installed." >> "$FULL_PATH/yggdrasil.log"
                                Temp_GIT_Name=$(echo "$2" | rev | cut -d '/' -f1 | rev)
                                if [[ ${Array_GIT_Updater[*]} != "$Temp_GIT_Name" ]]; then
                                        if [[ "$Switch_WGET" == false ]]; then
                                                Array_GIT_Updater+=("$Temp_GIT_Name")
                                        fi
                                fi
                        else
                                echo "$2 was not installed." >> "$FULL_PATH/yggdrasil.log"
                        fi
                elif [[ $1 =~ "pip3" ]]; then
                        if pip3 freeze | grep -q "$2"; then
                                echo "$2 was successfully installed." >> "$FULL_PATH/yggdrasil.log"
                        else
                                echo "$2 was not installed." >> "$FULL_PATH/yggdrasil.log"
                        fi
                fi
        }

	if [[ ! -d "/opt/hashcat_rules" || ! -d "/opt/wordlists" ]]; then
		mkdir -p /opt/hashcat_rules /opt/wordlists
 	fi

	if [[ ! -d "$OPT_Path" ]]; then
		mkdir -p "$OPT_Path"
 	fi

        Create_Filter_Array $1

        input=$1
        while IFS= read -r line
        do
                if [[ $line = "# APT" ]]; then
                        if [[ "$Switch_Verbose" == false ]]; then
                                 Command="sudo DEBIAN_FRONTEND=noninteractive apt install -y" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                        else
                                 Command="sudo apt install -y" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                        fi
                elif [[ $line = "# Cargo" ]]; then
                        Command="cargo install" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# Docker" ]]; then
                        Command="docker pull" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# Python" ]]; then
                        Command="pip3 install" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# NPM" ]]; then
                        Command="npm install --global" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# Git" ]]; then
                        Command="git clone" ; Skip=true ; mkdir -p "$2" ; cd "$2" || return 0 ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# Git_Branch" ]]; then
                        Command="git clone -b" ; Skip=true ; mkdir -p "$2" ; cd "$2" || return 0 ; Switch_WGET=false ; Switch_BRANCH=true ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# BloodHound_Cyphers" ]]; then
                        Command="echo 'UNDER CONSTRUCTION'" ; Switch_BloodHound=true; Skip=true; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false
                elif [[ $line = "# Git_Submodules" ]]; then
                        Command="git clone --recurse-submodules" ; Skip=true ; mkdir -p "$2" ; cd "$2" || return 0 ; Switch_WGET=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# Gem" ]]; then
                        Command="gem install" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# Go" ]]; then
                        Command="git clone" ; Skip=true ; mkdir -p "$2" ; cd "$2" || return 0 ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=true ; Switch_BloodHound=false
                elif [[ $line = "# Wordlists" ]]; then
                        Command="git clone" ; Skip=true ; mkdir -p /opt/wordlists ; cd /opt/wordlists || return 0 ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# Hashcat_Rules" ]]; then
                        Command="git clone" ; Skip=true ; mkdir -p /opt/hashcat_rules ; cd /opt/hashcat_rules || return 0 ; Switch_WGET=false ; Switch_BRANCH=false ; Switch_GO=false ; Switch_BloodHound=false
                elif [[ $line = "# Wget" ]]; then
                        Switch_WGET=true
                else
                        if [ "$Skip" = false ] && [ ! "$line" = "" ]; then
                                if [ "$Switch_WGET" = false ]; then
                                        if [[ $line =~ "github" ]]; then
					        if [[ "$Switch_BRANCH" == false ]]; then
                                                    echo -e "${CYAN}-------------------------------------------------------------------------------${NOCOLOR}\n\nDownload ${ORANGE}$(echo "$line" | cut -d "/" -f5)${NOCOLOR}"  | tee -a "$FULL_PATH/yggdrasil.log"
                                                else
                                                    echo -e "${CYAN}-------------------------------------------------------------------------------${NOCOLOR}\n\nDownload ${ORANGE}$(echo "$line" | cut -d "/" -f5 | cut -d " " -f1)${NOCOLOR}"  | tee -a "$FULL_PATH/yggdrasil.log"
						fi
                                                for CHECK_GIT in "${Array_Filter_Git[@]}"; do
                                                        if [[ $CHECK_GIT =~ $(echo "$line" | cut -d "/" -f5) ]]; then
                                                                if [[ "$CHECK_GIT" =~ "/opt/pentest_tools" ]]; then
                                                                        TEMP_GIT_PATH="${CHECK_GIT/"/opt/pentest_tools"/"$OPT_Path"}"
                                                                elif [[ "$CHECK_GIT" =~ "/opt/forensic_tools" ]]; then
                                                                        TEMP_GIT_PATH="${CHECK_GIT/"/opt/forensic_tools"/"$OPT_Path"}"
                                                                else
                                                                        TEMP_GIT_PATH="$CHECK_GIT"
                                                                fi
                                                                if [[ -d "$TEMP_GIT_PATH" ]]; then
                                                                        Switch_IGNORE=true
                                                                        break
                                                                fi
                                                        fi
                                                done
                                        else
                                                echo -e "${CYAN}-------------------------------------------------------------------------------${NOCOLOR}\n\nDownload ${ORANGE}$line${NOCOLOR}" | tee -a "$FULL_PATH/yggdrasil.log"
                                        fi
                                        if [ "$Switch_Skip_Hardening" = true ]; then
                                                if [[ $line =~ "iptables-persistent" || $line =~ "netfilter-persistent" || $line =~ "charon" || $line =~ "strongswan" || $line =~ "openconnect" || $line =~ "opensc" ]]; then
                                                        echo -e "${RED}$line${NOCOLOR} was skipped" | tee -a "$FULL_PATH/yggdrasil.log"
                                                else
							Download_Commander
                                                fi
                                        else
						Download_Commander
                                        fi
                                else
                                        FILE=$(echo "$line" | cut -d" " -f1)
                                        FILE_NAME=$(echo "$line" | cut -d" " -f2)
                                        if [[ $(echo "$line" | cut -d" " -f3) = "Extension" ]]; then
                                                echo -e "${CYAN}-------------------------------------------------------------------------------${NOCOLOR}\n\nDownload ${ORANGE}$FILE_NAME${NOCOLOR}"
                                        else
                                                echo -e "${CYAN}-------------------------------------------------------------------------------${NOCOLOR}\n\nDownload ${ORANGE}$FILE_NAME${NOCOLOR}" | tee -a "$FULL_PATH/yggdrasil.log"
                                        fi
                                        for CHECK_FILE in "${Array_Filter_Download[@]}"; do
                                                if [[ $CHECK_FILE =~ $FILE_NAME ]]; then
							if [[ "$CHECK_FILE" =~ "/opt/pentest_tools" ]]; then
								TEMP_WGET_PATH="${CHECK_FILE/"/opt/pentest_tools"/"$OPT_Path"}"
							elif [[ "$CHECK_FILE" =~ "/opt/forensic_tools" ]]; then
								TEMP_WGET_PATH="${CHECK_FILE/"/opt/forensic_tools"/"$OPT_Path"}"
							else
								TEMP_WGET_PATH="$CHECK_FILE"
							fi
                                                        if [[ "$(echo "$TEMP_WGET_PATH" | awk -F "$(echo "$TEMP_WGET_PATH" | rev | cut -c2- | rev)" '{print $2}')" == "*" ]]; then
                                                                SEARCH_PATTERN="$(echo "$TEMP_WGET_PATH" | rev | cut -d '/' -f1 | rev)"
                                                                REST_OF_FILE="$(echo "$TEMP_WGET_PATH" | tr '/' ' ')"
                                                                TEMP_DIRECTORY=""
                                                                for i in $REST_OF_FILE; do if [[ "$i" != "$SEARCH_PATTERN" ]]; then TEMP_DIRECTORY+="/$i"; fi; done
                                                                if find "$TEMP_DIRECTORY" -maxdepth 1 ! -path "$TEMP_DIRECTORY" | grep -q "$SEARCH_PATTERN"; then
                                                                        Switch_IGNORE=true
                                                                        break
                                                                fi
                                                        else
                                                                if [[ $(ls "$TEMP_WGET_PATH" 2>/dev/null) ]]; then
                                                                        Switch_IGNORE=true
                                                                        break
                                                                fi
                                                        fi
                                                fi
                                        done
                                        if [[ $Switch_IGNORE = false ]]; then
                                                MODE=$(echo "$line" | cut -d" " -f3)
                                                mkdir -p "$2" ; cd "$2" || return 0
                                                if [ "$MODE" = "Executable" ]; then
                                                        mkdir -p "$2"/"$FILE_NAME" ; cd "$2"/"$FILE_NAME" || return 0
                                                        wget "$FILE" -O "$FILE_NAME"
                                                        chmod +x "$FILE_NAME" ; cd "$2" || return 0
                                                elif [ "$MODE" = "Archive" ]; then
                                                        wget --content-disposition "$FILE"
							TEMP_SECOND_PART_FILE="$FILE_NAME"
                                                        FILE_NAME=$(curl -L --head -s "$FILE" | grep filename | tail -n1 | cut -d "=" -f2)
                                                        if [[ ${#FILE_NAME} -gt 0 ]]; then
                                                                sudo python3 "$FULL_PATH/Resources/Python/zip.py" "$FILE_NAME" "$2" "$TEMP_SECOND_PART_FILE"
                                                        else
                                                                sudo python3 "$FULL_PATH/Resources/Python/zip.py" "$FILE" "$2" "$TEMP_SECOND_PART_FILE"
                                                        fi
                                                elif [ "$MODE" = "Installer" ]; then
                                                        FILE_NAME=$(curl -L --head -s "$FILE" | grep filename | tail -n1 | cut -d "=" -f2)
                                                        if [[ "$FILE_NAME" =~ "rustup-init.sh" ]]; then
								Temp_Rust_Array=($(find "/home" "/root" -maxdepth 3 -name ".cargo"))
								if [[ ${#Temp_Rust_Array} -eq 0 ]]; then
									wget --content-disposition "$FILE"
									sudo bash "$2"/"$(echo "$FILE_NAME" | cut -d '"' -f2)" -y | tee -a "$FULL_PATH/yggdrasil.log"
									if [[ -d "/root/.cargo" ]]; then
										Switch_Cargo=true
									fi
									source "$HOME/.cargo/env"
	 							else
	 								echo -e "${RED}rust${NOCOLOR} already exists." | tee -a "$FULL_PATH/yggdrasil.log"
	 							fi
                                                        else
								wget --content-disposition "$FILE"
                                                                sudo bash "$2"/"$(echo "$FILE_NAME" | cut -d '"' -f2)" | tee -a "$FULL_PATH/yggdrasil.log"
                                                        fi
                                                elif [ "$MODE" = "Extension" ]; then
                                                        wget --content-disposition "$FILE"
                                                        FILE_NAME=$(curl -L --head -s "$FILE" | grep filename | tail -n1 | cut -d "=" -f2)
                                                elif [ "$MODE" = "DPKG" ]; then
                                                        FILE_NAME=$(curl -L --head -s "$FILE" | grep filename | tail -n1 | cut -d "=" -f2)
                                                        if [[ ${#FILE_NAME} -gt 0 ]]; then
                                                                wget --content-disposition "$FILE"
								sudo python3 "$FULL_PATH/Resources/Python/install.py" "$2/$(echo $FILE_NAME | cut -d '"' -f2)" | tee -a "$FULL_PATH/yggdrasil.log"
                                                        else
                                                                FILE_NAME=$(echo "$line" | cut -d" " -f2)
                                                                wget "$FILE" -O "$FILE_NAME".deb
								sudo python3 "$FULL_PATH/Resources/Python/install.py" "$2/$(echo $FILE_NAME | cut -d '"' -f2).deb" | tee -a "$FULL_PATH/yggdrasil.log"
                                                        fi
                                        fi
                                                Logger "$FILE" "$FILE_NAME"
                                        else
                                                echo -e "${RED}$FILE_NAME${NOCOLOR} already exists." | tee -a "$FULL_PATH/yggdrasil.log"
                                        fi
                                fi
                        fi
                fi
                Skip=false
                Switch_IGNORE=false
                sleep 0.2
        done < "$input"
}

function Config_Reader() {
	input=$1
 	while IFS= read -r line
	do
 		echo "Lorem Ipsum"
  	done < "$input"
}

function File_Reader() {
        input=$1
        while IFS= read -r line
        do
                if [[ $line =~ "##" ]]; then
                        echo -e "${GREEN}$line${NOCOLOR}"
                else
                        echo -e "${ORANGE}$line${NOCOLOR}"
                fi
        done < "$input"
}

function Forensic_Check() {
        forensic_type=$1
	if [[ $forensic_type == "complete" || $forensic_type == "1" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Forensic/Cloud")
              Array_Categories+=("$FULL_PATH/Config/Linux/Forensic/Crypto")
              Array_Categories+=("$FULL_PATH/Config/Linux/Forensic/Infrastructure")
              Array_Categories+=("$FULL_PATH/Config/Linux/Forensic/Mobile")
	elif [[ $forensic_type == "cloud" || $forensic_type == "2" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Forensic/Cloud")
	elif [[ $forensic_type == "crypto" || $forensic_type == "3" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Forensic/Crypto")
	elif [[ $forensic_type == "infrastructure" || $forensic_type == "4" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Forensic/Infrastructure")
	elif [[ $forensic_type == "mobile" || $forensic_type == "5" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Forensic/Mobile")
	else
	      echo -e "\nYour decision was not accepted!\nPlease try again."
              Show_Error_Message=true
	fi
        Array_URL+=("$FULL_PATH/Information/Pages/Forensic.txt")
}

function Hardening_Check() {
        hardening_type=$1
	if [[ $hardening_type == "complete" || $hardening_type == "1" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Hardening/Cloud")
              Array_Categories+=("$FULL_PATH/Config/Linux/Hardening/Infrastructure")
	elif [[ $hardening_type == "cloud" || $hardening_type == "2" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Hardening/Cloud")
	elif [[ $hardening_type == "infrastructure" || $hardening_type == "3" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Hardening/Infrastructure")
	else
	      echo -e "\nYour decision was not accepted!\nPlease try again."
              Show_Error_Message=true
	fi
        Array_URL+=("$FULL_PATH/Information/Pages/Hardening.txt")
}

function Pentest_Check() {
        pentest_check=$1
	if [[ $pentest_check = "infrastructure" || $pentest_check = "1" ]]; then
		Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Infrastructure")
		Array_URL+=("$FULL_PATH/Information/Pages/Infrastructure.txt")
	elif [[ $pentest_check = "iot" || $pentest_check = "2" ]]; then
		Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/IOT")
	elif [[ $pentest_check = "mobile" || $pentest_check = "3" ]]; then
		Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Mobile")
	elif [[ $pentest_check = "web" || $pentest_check = "4" ]]; then
		Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Web")
		Array_URL+=("$FULL_PATH/Information/Pages/Web.txt")
	elif [[ $pentest_check = "cloud" || $pentest_check = "5" ]]; then
		Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Cloud")
	else
		echo -e "\nYour decision was not accepted!\nPlease try again."
                Show_Error_Message=true
	fi
}

function Red_Team_Check() {
        red_team=$1
	if [[ $red_team == "complete" || $red_team == "1" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Red_Teaming/Active_Directory")
              Array_Categories+=("$FULL_PATH/Config/Linux/Red_Teaming/OSINT")
              Array_Categories+=("$FULL_PATH/Config/Linux/Red_Teaming/Phishing")
              Array_Categories+=("$FULL_PATH/Config/Linux/Red_Teaming/Physical_Pentesting")
              Array_URL+=("$FULL_PATH/Information/Pages/OSINT.txt")
	elif [[ $red_team == "active_directory" || $red_team == "2" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Red_Teaming/Active_Directory")
	elif [[ $red_team == "osint" || $red_team == "3" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Red_Teaming/OSINT")
	      Array_URL+=("$FULL_PATH/Information/Pages/OSINT.txt")
	elif [[ $red_team == "phishing" || $red_team == "4" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Red_Teaming/Phishing")
	elif [[ $red_team == "physical" || $red_team == "5" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Red_Teaming/Physical_Pentesting")
	else
	      echo -e "\nYour decision was not accepted!\nPlease try again."
              Show_Error_Message=true
	fi
}

function Development_Check() {
        development=$1
	if [[ $development == "complete" || $development == "1" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Development/Exploit_Development")
              Array_Categories+=("$FULL_PATH/Config/Linux/Development/Reverse_Engineering")
              Array_Categories+=("$FULL_PATH/Config/Linux/Development/Source_Code_Analysis")
	      Array_Categories+=("$FULL_PATH/Config/Linux/Development/Malware_Development")
	elif [[ $development == "source_code_analysis" || $development == "2" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Development/Source_Code_Analysis")
	elif [[ $development == "reverse_engineering" || $development == "3" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Development/Reverse_Engineering")
	elif [[ $development == "exploit_development" || $development == "4" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Development/Exploit_Development")
       	elif [[ $development == "malware_development" || $development == "5" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Development/Malware_Development")
	else
	      echo -e "\nYour decision was not accepted!\nPlease try again."
              Show_Error_Message=true
	fi
}

function Category_Loop() {
	while true;
	do
		header "$1"
  		read -rp "Your Choice: " temp_check_input
    		if [[ "$temp_check_input" =~ "," ]]; then
			IFS=", "
   			Array_Temp_Check=($temp_check_input)
      			for Check_category in "${Array_Temp_Check[@]}"; do
				$2 $Check_category
  			done
     		else
       			$2 $temp_check_input
      		fi

		if [[ "$Show_Error_Message" == true ]]; then
  			clearing
     		else
   			break
  		fi
                Show_Error_Message=false
 	done
}

# Checking_Parameters
for arg; do
        if [[ $arg == "-sH" ]]; then
                Switch_Skip_Hardening=true
        elif [[ $arg == "-sC" ]]; then
                Switch_Skip_Configs=true
        elif [[ $arg == "-aL" ]]; then
                Switch_License=true
        elif [[ $arg == "-v" ]]; then
                Switch_Verbose=true
	elif [[ $arg == "-sI" ]]; then
 		Switch_Skip_Installation=true
        elif [[ $arg == "-sU" ]]; then
                Switch_Skip_URLS=true
	elif [[ $arg == "-sbI" ]]; then
 		Switch_Skip_Basic_Installation=true
        elif [[ "$(echo "$arg" | awk -F "$(echo "$arg" | rev | cut -c5- | rev)" '{print $2}')" == ".-aW" ]]; then
                PATH_WORKSPACE="$(echo "$arg" | rev | cut -c5- | rev)"
        elif [[ "$(echo "$arg" | awk -F "$(echo "$arg" | rev | cut -c4- | rev)" '{print $2}')" == ".-p" ]]; then
                PATH_Install_Dir="$(echo "$arg" | rev | cut -c4- | rev)"
        elif [[ "$(echo "$arg" | awk -F "$(echo "$arg" | rev | cut -c5- | rev)" '{print $2}')" == ".-hN" ]]; then
                HOST_Pentest="$(echo "$arg" | rev | cut -c5- | rev)"
        elif [[ "$(echo "$arg" | awk -F "$(echo "$arg" | rev | cut -c5- | rev)" '{print $2}')" == ".-tP" ]]; then
                OPT_Path="$(echo "$arg" | rev | cut -c5- | rev)"
        elif [[ "$(echo "$arg" | awk -F "$(echo "$arg" | rev | cut -c5- | rev)" '{print $2}')" == ".-cD" ]]; then
                Shredding_DAYS="$(echo "$arg" | rev | cut -c5- | rev)"
        elif [[ "$(echo "$arg" | awk -F "$(echo "$arg" | rev | cut -c6- | rev)" '{print $2}')" == ".-rCf" ]]; then
                PATH_Config_File="$(echo "$arg" | rev | cut -c6- | rev)"
        fi
done

# Category
if [[ "$Switch_Skip_Installation" == false ]]; then
	header "category"
	read -rp "Your Choice: " category_type
	if [[ $category_type = "forensic" || $category_type = "3" ]]; then
	        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
	                OPT_Path="/opt/forensic_tools"
	        fi
	        if [[ $HOST_Pentest == "pentest-kali" ]]; then
	                HOST_Pentest="forensic-kali"
	        fi
                Category_Loop "forensic" Forensic_Check

	elif [[ $category_type = "pentest" || $category_type = "4" ]]; then
	        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
	                OPT_Path="/opt/pentest_tools"
                fi
                Category_Loop "pentesting_category" Pentest_Check

	elif [[ $category_type = "hardening" || $category_type = "5" ]]; then
	        Path_Way="$FULL_PATH/Config/Linux/Hardening"
	        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
	                OPT_Path="/opt/hardening_tools"
	        fi
                Category_Loop "hardening_category" Hardening_Check

	elif [[ $category_type = "training" || $category_type = "6" ]]; then
	        Path_Way="$FULL_PATH/Config/Linux/Training"
	        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
	                OPT_Path="/opt/training_tools"
	        fi
	        Array_URL+=("$FULL_PATH/Information/Pages/Education.txt")

	elif [[ $category_type = "red_teaming" || $category_type = "7" ]]; then
	        Path_Way="$FULL_PATH/Config/Linux/Red_Teaming"
	        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
	                OPT_Path="/opt/red_teaming_tools"
	        fi
		Category_Loop "red_team" Red_Team_Check

	elif [[ $category_type == "development" || $category_type == "8" ]]; then
		Path_Way="$FULL_PATH/Config/Linux/Development"
	        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
	                OPT_Path="/opt/development_tools"
	        fi
		Category_Loop "development" Development_Check

	elif [[ $category_type = "custom" || $category_type = "2" ]]; then
	        Path_Way="$FULL_PATH/Config/Linux/Custom"
	        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
	                OPT_Path="/opt/custom_yggdrasil_tools"
	        fi
		Array_URL+=("$FULL_PATH/Information/Pages/Custom.txt")
	elif [[ $category_type = "complete" || $category_type = "1" ]]; then
	        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
	                OPT_Path="/opt/complete_tools"
	        fi
	        declare -a Array_URL=("$FULL_PATH/Information/Pages/Infrastructure.txt"
	"$FULL_PATH/Information/Pages/OSINT.txt"
	"$FULL_PATH/Information/Pages/Forensic.txt"
	"$FULL_PATH/Information/Pages/Hardening.txt"
 	"$FULL_PATH/Information/Pages/Web.txt")
	else
	        echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
	fi

	# Installation_Type
	if [[ $category_type = "custom" || $category_type = "2" ]]; then
	        File_Path="${Path_Way}/install.txt"
	        Informational="$FULL_PATH/Information/info.txt"
	elif [[ $category_type = "complete" || $category_type = "1" ]]; then
	        decision="0"
	        Informational="$FULL_PATH/Information/info.txt"
	elif [[ $category_type = "hardening" || $category_type = "5" ]]; then
	        File_Path="${Path_Way}/full.txt"
	        Informational="$FULL_PATH/Information/info.txt"
	else
	        if [[ ${#Array_Categories[@]} -gt 0  ]]; then
	 		if [[ ${#Array_Categories[@]} -gt 1 ]]; then
		                Path_Way="$FULL_PATH/Config/Linux/Pentest/Infrastructure"
		                File_Path="${Path_Way}/full.txt"
		                Informational="$FULL_PATH/Information/info.txt"
		                decision="full"
		        else
		                if [[ $pentest_check = "iot" || $pentest_check = "2" || $pentest_check = "mobile" || $pentest_check = "3" || $pentest_check = "web" || $pentest_check = "4" || $pentest_check = "cloud" || $pentest_check = "5" || $red_team = "1" || $red_team = "complete" || $red_team = "2" || $red_team = "active_directory" || $red_team = "3" || $red_team = "osint" || $red_team = "4" || $red_team = "phishing" || $red_team = "5" || $red_team = "physical" ]]; then
		                        File_Path="${Path_Way}/full.txt"
		                        decision="full"
		                        Informational="$FULL_PATH/Information/info.txt"
		                elif [[ $pentest_check = "infrastructure" || $pentest_check = "1" || $forensic_type = "infrastructure" || $forensic_type = "4" ]]; then
		                        header "installation"
		                        read -rp "Your Choice: " decision
		                        if [[ $decision = "full" || $decision = "1" ]]; then
		                                File_Path="${Path_Way}/full.txt"
		                                if [[ $category_type = "pentest" || $category_type = "4" ]]; then
		                                       Informational="$FULL_PATH/Information/info.txt"
		                                fi
		                        elif [[ $decision = "minimal" || $decision = "2" ]]; then
		                                File_Path="${Path_Way}/minimal.txt"
		                                Switch_URL=false
		                        else
		                                echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
		                        fi
		                fi
		        fi
	  	fi
	fi
else
	if [ -d "/opt/pentest_tools" ]; then
		OPT_Path="/opt/pentest_tools"
 	elif [ -d "/opt/forensic_tools" ]; then
  		OPT_Path="/opt/forensic_tools"
    	elif [ -d "/opt/hardening_tools" ]; then
     		OPT_Path="/opt/hardening_tools"
        elif [ -d "/opt/custom_yggdrasil_tools" ]; then
		OPT_Path="/opt/custom_yggdrasil_tools"
	elif [ -d "/opt/training_tools" ]; then
 		OPT_Path="/opt/training_tools"
   	elif [ -d "/opt/red_teaming_tools" ]; then
 		OPT_Path="/opt/red_teaming_tools"
      	elif [ -d "/opt/development_tools" ]; then
 		OPT_Path="/opt/development_tools"
 	elif [ -d "/opt/complete_tools" ]; then
  		OPT_Path="/opt/complete_tools"
	else
 		if [[ ! "${#OPT_Path}" -gt 2 ]]; then
			OPT_Path="/opt/pentest_tools"
   		fi
	fi
fi

# Hardening_Configuration
if [[ $Switch_Skip_Hardening != true ]]; then
	while true;
 	do
	        header "hardening"
	        read -rp "Your Choice: " hardening
	        if [[ $hardening =~ "," ]]; then
	                IFS=", "
	                Array_Hardening=($hardening)
	                for testing_category in "${Array_Hardening[@]}"; do
	                        if [[ $testing_category == "firewall" || $testing_category == "2" ]]; then
	                                Switch_Firewall=true
	                        elif [[ $testing_category == "sysctl" || $testing_category == "3" ]]; then
	                                Switch_Hardening=true
	                        elif [[ $testing_category == "ssh" || $testing_category == "4" ]]; then
	                                Switch_SSH=true
	                        elif [[ $testing_category == "apache" || $testing_category == "5" ]]; then
	                                Switch_APACHE=true
	                        elif [[ $testing_category == "nginx" || $testing_category == "6" ]]; then
	                                Switch_NGINX=true
		                elif [[ $testing_category = "smb" || $testing_category = "7" ]]; then
		                        Switch_SMB=true
		#                elif [[ $testing_category = "ftp" || $testing_category = "8" ]]; then
		#                        Switch_FTP=true
		#                elif [[ $testing_category = "squid" || $testing_category = "9" ]]; then
		#                        Switch_SQUID=true
	                        fi
	                done
	        else
	                if [[ $hardening = "complete" || $hardening = "1" ]]; then
	                        Switch_Firewall=true ; Switch_Hardening=true ; Switch_SSH=true ; Switch_APACHE=true ; Switch_NGINX=true ; Switch_SMB=true #; Switch_FTP=true ; Switch_SQUID=true
	                elif [[ $hardening = "firewall" || $hardening = "2" ]]; then
	                        Switch_Firewall=true
	                elif [[ $hardening = "sysctl" || $hardening = "3" ]]; then
	                        Switch_Hardening=true
	                elif [[ $hardening = "ssh" || $hardening = "4" ]]; then
	                        Switch_SSH=true
	                elif [[ $hardening = "apache" || $hardening = "5" ]]; then
	                        Switch_APACHE=true
	                elif [[ $hardening = "nginx" || $hardening = "6" ]]; then
	                        Switch_NGINX=true
	                elif [[ $hardening = "smb" || $hardening = "7" ]]; then
	                        Switch_SMB=true
	#                elif [[ $hardening = "ftp" || $hardening = "8" ]]; then
	#                        Switch_FTP=true
	#                elif [[ $hardening = "squid" || $hardening = "9" ]]; then
	#                        Switch_SQUID=true
			else
				echo -e "\nYour decision was not accepted!\nPlease try again."
				Show_Error_Message=true
			fi
   		fi

	        if [[ "$Show_Error_Message" == true ]]; then
  			clearing
     		else
   			break
  		fi
                Show_Error_Message=false
	done
        clearing

        # SSH_Configuration
        if [[ $Switch_SSH != false ]]; then
		while true;
  		do
	                echo -e "\n             Please select an IP address to be used\n                     for SSH configuration"
	                echo -e "${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
	                sudo python3 "$FULL_PATH/Resources/Python/nic.py"
	                echo -e "\n${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
	                read -rp "Your Choice: " IP_TEMP
	                if [[ ${#IP_TEMP} -gt 0 ]]; then
	                        LEN_CHECK=$(ip a | grep "$IP_TEMP")
	                        if [[ ${#LEN_CHECK} -gt 0 ]] && [[ ${IP_TEMP} = *"."* ]]; then
	                                IP_INT=$IP_TEMP
	                        elif [[ ${#LEN_CHECK} -gt 0 ]] && [[ ${IP_TEMP} = *":"* ]]; then
	                                IP_INT="[$IP_TEMP]"
	                        else
	                                echo -e "\nYour decision was not accepted!\nPlease try again."
					Show_Error_Message=true
	                        fi
	                        clearing
	                else
	                        echo -e "\nYour decision was not accepted!\nPlease try again."
				Show_Error_Message=true
	                fi

			if [[ "$Show_Error_Message" == true ]]; then
	  			clearing
	     		else
	   			break
	  		fi
	                Show_Error_Message=false
		done
        fi

        # SMB_Configuration
	if [[ $Switch_SMB != false ]]; then
		# IP_Addresses
		while true;
  		do
	                echo -e "\n             Please select an IP address to be used\n                     for SMB configuration"
	                echo -e "${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
	                sudo python3 "$FULL_PATH/Resources/Python/nic.py"
	                echo -e "\n${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
	                read -rp "Your Choice: " IP_TEMP
	                if [[ ${#IP_TEMP} -gt 0 ]]; then
	                        LEN_CHECK=$(ip a | grep "$IP_TEMP")
	                        if [[ ${#LEN_CHECK} -gt 0 ]] && [[ ${IP_TEMP} = *"."* ]]; then
	                                SMB_IP_Addresses=$IP_TEMP
	                        elif [[ ${#LEN_CHECK} -gt 0 ]] && [[ ${IP_TEMP} = *":"* ]]; then
	                                SMB_IP_Addresses="[$IP_TEMP]"
	                        else
	                                echo -e "\nYour decision was not accepted!\nPlease try again."
					Show_Error_Message=true
	                        fi
	                else
	                        echo -e "\nYour decision was not accepted!\nPlease try again."
				Show_Error_Message=true
	                fi

			if [[ "$Show_Error_Message" == true ]]; then
	  			clearing
	     		else
	   			break
	  		fi
	                Show_Error_Message=false
    		done

		# Share_Name
		while true;
  		do
                        read -rp "Share name: " SMB_Share_Name
	                if [[ ${#SMB_Share_Name} -gt 0 ]]; then
	                        Show_Error_Message=false
	                else
	                        echo -e "\nYour decision was not accepted!\nPlease try again."
				Show_Error_Message=true
	                fi

			if [[ "$Show_Error_Message" == true ]]; then
	  			clearing
	     		else
	   			break
	  		fi
	                Show_Error_Message=false
		done

  		# Share_Path
    		while true;
  		do
                        read -rp "Full share path: " SMB_Share_Path
	                if [[ ${#SMB_Share_Path} -gt 0 ]]; then
			        if [[ ! -d "$SMB_Share_Path" ]]; then
	                             read -rp "The path doesn't exist! Should it be created (y/N): " SMB_Choice
                                     if [[ $SMB_Choice == "y" || $SMB_Choice == "Y" ]]; then
                                         sudo mkdir -p $SMB_Share_Path
			             else
		                         echo -e "\nYour decision was not accepted!\nPlease try again."
				         Show_Error_Message=true
                                     fi
	                        fi
	                else
	                        echo -e "\nYour decision was not accepted!\nPlease try again."
				Show_Error_Message=true
	                fi

			if [[ "$Show_Error_Message" == true ]]; then
	  			clearing
	     		else
	   			break
	  		fi
	                Show_Error_Message=false
		done

      		# Share_Hosts
		while true;
  		do
                        read -rp "SMB Hosts that could connect to the share (Hostnames or IP-Addresses): " SMB_Hosts
	                if [[ ${#SMB_Hosts} -gt 0 ]]; then
                                Show_Error_Message=false
	                else
	                        echo -e "\nYour decision was not accepted!\nPlease try again."
				Show_Error_Message=true
	                fi

			if [[ "$Show_Error_Message" == true ]]; then
	  			clearing
	     		else
	   			break
	  		fi
	                Show_Error_Message=false
		done

    		# Share_User
		while true;
  		do
                        read -rp "Valid user list: " SMB_Valid_Users
	                if [[ ${#SMB_Valid_Users} -gt 0 ]]; then
	                        clearing
	                else
	                        echo -e "\nYour decision was not accepted!\nPlease try again."
				Show_Error_Message=true
	                fi

			if [[ "$Show_Error_Message" == true ]]; then
	  			clearing
	     		else
	   			break
	  		fi
	                Show_Error_Message=false
		done
        fi
else
        clearing
fi

# Settings_Configuration
if [[ $Switch_Skip_Configs != true ]]; then
	while true;
 	do
	        header "settings"
	        read -rp "Your Choice: " custom_settings
	        if [[ $custom_settings =~ "," ]]; then
	                IFS=", "
	                Array_Custom_Settings=($custom_settings)
	                for Cust_Setting in "${Array_Custom_Settings[@]}"; do
	                        if [[ $Cust_Setting == "updates" || $Cust_Setting == "2" ]]; then
	                                Switch_UPDATES=true
	                        elif [[ $Cust_Setting == "alias" || $Cust_Setting == "3" ]]; then
	                                Switch_CUSTOM_CONFIGS=true
	                        elif [[ $Cust_Setting == "screenrc" || $Cust_Setting == "4" ]]; then
	                                Switch_SCREENRC=true
	                        elif [[ $Cust_Setting == "vim" || $Cust_Setting == "5" ]]; then
	                                Switch_VIM_CONFIG=true
	                        elif [[ $Cust_Setting == "repo" || $Cust_Setting == "6" ]]; then
	                                Switch_REPO=true
	                        elif [[ $Cust_Setting == "shredder" || $Cust_Setting == "7" ]]; then
	                                Switch_SHREDDER=true
	                        elif [[ $Cust_Setting == "tmux" || $Cust_Setting == "8" ]]; then
	                                Switch_TMUX=true
	                        fi
	                done
	        else
	                if [[ $custom_settings = "complete" || $custom_settings = "1" ]]; then
	                        Switch_UPDATES=true ; Switch_CUSTOM_CONFIGS=true ; Switch_SCREENRC=true ; Switch_VIM_CONFIG=true ; Switch_REPO=true ; Switch_SHREDDER=true ; Switch_TMUX=true
	                elif [[ $custom_settings = "updates" || $custom_settings = "2" ]]; then
	                        Switch_UPDATES=true
	                elif [[ $custom_settings = "alias" || $custom_settings = "3" ]]; then
	                        Switch_CUSTOM_CONFIGS=true
	                elif [[ $custom_settings = "screenrc" || $custom_settings = "4" ]]; then
	                        Switch_SCREENRC=true
	                elif [[ $custom_settings = "vim" || $custom_settings = "5" ]]; then
	                        Switch_VIM_CONFIG=true
	                elif [[ $custom_settings = "repo" || $custom_settings = "6" ]]; then
	                        Switch_REPO=true
	                elif [[ $custom_settings = "shredder" || $custom_settings = "7" ]]; then
	                        Switch_SHREDDER=true
	                elif [[ $custom_settings = "tmux" || $custom_settings = "8" ]]; then
	                        Switch_TMUX=true
	                else
	                        echo -e "\nYour decision was not accepted!\nPlease try again."
				Show_Error_Message=true
	                fi
	        fi

		if [[ "$Show_Error_Message" == true ]]; then
  			clearing
     		else
   			break
  		fi
                Show_Error_Message=false
	done
        clearing
fi

# VIM_Configuration
if [[ $Switch_VIM_CONFIG = true ]]; then
	while true;
 	do
	        header "vim"
	        read -rp "Your Choice: " vim_settings
	        if [[ $vim_settings = "homesen" || $vim_settings = "1" ]]; then
	                Switch_VIM_HOMESEN=true
	        elif [[ $vim_settings = "nayaningaloo" || $vim_settings = "2" ]]; then
	                Switch_VIM_NAYANINGALOO=true
	        else
	                echo -e "\nYour decision was not accepted!\nPlease try again."
			Show_Error_Message=true
	        fi

		if [[ "$Show_Error_Message" == true ]]; then
  			clearing
     		else
   			break
  		fi
                Show_Error_Message=false
	done
        clearing
fi

# Screenrc_Configuration
if [[ $Switch_SCREENRC = true ]]; then
	while true;
 	do
	        header "screenrc"
	        read -rp "Your Choice: " screenrc_settings
	        if [[ $screenrc_settings = "homesen" || $screenrc_settings = "1" ]]; then
	                Switch_SCREENRC_HOMESEN=true
	        elif [[ $screenrc_settings = "jarl-bjoern" || $screenrc_settings = "2" ]]; then
	                Switch_SCREENRC_BJOERN=true
	        else
	                echo -e "\nYour decision was not accepted!\nPlease try again."
			Show_Error_Message=true
	        fi

		if [[ "$Show_Error_Message" == true ]]; then
  			clearing
     		else
   			break
  		fi
                Show_Error_Message=false
	done
        clearing
fi

# Updater_Configuration
if [[ $Switch_UPDATES = true || $Switch_SHREDDER = true ]]; then
	while true;
	do
	        header "task"
	        read -rp "Your Choice: " task_settings
	        if [[ $task_settings = "cronjob" || $task_settings = "1" ]]; then
	                Switch_CRON=true
	        elif [[ $task_settings = "timer" || $task_settings = "2" ]]; then
	                Switch_SYSTEMD=true
	        else
	                echo -e "\nYour decision was not accepted!\nPlease try again."
		        Show_Error_Message=true
	        fi

		if [[ "$Show_Error_Message" == true ]]; then
  			clearing
     		else
   			break
  		fi
                Show_Error_Message=false
	done
        clearing
fi

IFS="$OLDIFS"
# Basic_Configuration
if [[ $(grep "PRETTY_NAME" /etc/os-release | cut -d '"' -f2) =~ "Kali" ]]; then
        if [[ "$Switch_REPO" == true ]]; then
                sudo sed -i "s#deb http://http.kali.org/kali kali-rolling main contrib non-free#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free#g" /etc/apt/sources.list
        fi
fi
if [[ "$Switch_CUSTOM_CONFIGS" == true ]]; then
        export HISTCONTROL=ignoreboth:erasedups
fi
echo "" > "$FULL_PATH/yggdrasil.log"
if [[ "$Switch_Skip_Installation" == false && "$Switch_Skip_Basic_Installation" == false ]]; then
	if [[ "$Switch_Verbose" == false ]]; then
	         sudo apt update -y ; sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; sudo apt autoremove -y --purge ; sudo apt clean all
	else
	         sudo apt update -y ; sudo apt full-upgrade -y ; sudo apt autoremove -y --purge ; sudo apt clean all
	fi
 fi

if [[ "$Switch_Skip_Installation" == false ]]; then
	# Standard_Installation
	if [[ "$Switch_Skip_Hardening" != true ]]; then
	        echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
	        echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
	fi

 	if [[ $Switch_Skip_Basic_Installation == false ]]; then
		if [[ $category_type != "custom" && $category_type != "2" ]]; then
		        File_Installer "$FULL_PATH/Config/Linux/General/standard.txt" "$OPT_Path"
		        if [[ $decision = "full" || $decision = "1" || $category_type = "complete" || $category_type = "1" || ${#Array_Categories} -gt 0 ]]; then
		                File_Installer "$FULL_PATH/Config/Linux/General/gui.txt" "$OPT_Path"
		        fi
		fi
  	fi

	# Tool_Installation
	if [[ $category_type = "complete" || $category_type = "1" ]]; then
		Array_Complete_Install=($(find $FULL_PATH/Config/Linux -type f -name full.txt))
		for i in "${Array_Complete_Install[@]}"; do
	                File_Installer "$i" "$OPT_Path"
	        done
	else
	        if [[ ${#Array_Categories} -gt 0 ]]; then
	                for i in "${Array_Categories[@]}"; do
	                        File_Installer "${i}/full.txt" "$OPT_Path"
	                done
	        else
	                File_Installer "$File_Path" "$OPT_Path"
	        fi
	fi
 fi

# Task_Configuration
if [[ "$Switch_UPDATES" == true ]]; then
	mkdir -p /etc/yggdrasil ; chown root: /etc/yggdrasil
        if [[ "$Switch_CRON" == true ]]; then
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/etc/crontab" "$OPT_Path" "normal"
        elif [[ "$Switch_SYSTEMD" == true ]]; then
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/usr/lib/systemd/system" "$OPT_Path" "normal"
                sudo systemctl daemon-reload &>/dev/null
                echo -e "\nSetting up the timer and services.\n${CYAN}--------------------------------------------------------------------------------${NOCOLOR}\n"
                sudo systemctl enable --now Yggdrasil_Cargo_Updater.timer Yggdrasil_Container_Cleaner.timer Yggdrasil_Container_Updates.timer Yggdrasil_GIT_Updater.timer Yggdrasil_PIP_Updater.timer Yggdrasil_System_Updates.timer Yggdrasil_GIT_Monitor_Cleaner.timer Yggdrasil_GIT_Monitor.timer Yggdrasil_Rust_Updater.timer &>/dev/null
        fi
	chmod +x /etc/yggdrasil/*
fi
if [[ "$Switch_SHREDDER" == true ]]; then
	mkdir -p /etc/yggdrasil ; chown root: /etc/yggdrasil
        if [[ "$Switch_CRON" == true ]]; then
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/etc/crontab" "$PATH_WORKSPACE" "shred" "$Shredding_DAYS"
        elif [[ "$Switch_SYSTEMD" == true ]]; then
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/usr/lib/systemd/system" "$PATH_WORKSPACE" "shred" "$Shredding_DAYS"
		sudo systemctl daemon-reload &>/dev/null
                sudo systemctl enable --now Yggdrasil_Workspace_Cleaner.timer &>/dev/null
        fi
	chmod +x /etc/yggdrasil/*
fi

# Presetup_VIM_Config
if [[ $Switch_VIM_NAYANINGALOO == true ]]; then
	if [[ "$Switch_Verbose" == false ]]; then
		 sudo DEBIAN_FRONTEND=noninteractive apt install -y vim vim-addon-manager vim-addon-mw-utils vim-common vim-fugitive vim-git-hub vim-gitgutter vim-gtk3 vim-gui-common vim-latexsuite vim-pathogen vim-runtime vim-scripts vim-snipmate vim-snippets vim-tiny vim-tlib vim-icinga2 vim-airline vim-airline-themes shellcheck gitlint yamllint
	else
		 sudo apt install -y vim vim-addon-manager vim-addon-mw-utils vim-common vim-fugitive vim-git-hub vim-gitgutter vim-gtk3 vim-gui-common vim-latexsuite vim-pathogen vim-runtime vim-scripts vim-snipmate vim-snippets vim-tiny vim-tlib vim-icinga2 vim-airline vim-airline-themes shellcheck gitlint yamllint
	fi
        cd /tmp || return 0 ; git clone https://github.com/nayaningaloo/vim
fi

# Setup_TMUX_Conf
if [[ $Switch_TMUX == true ]]; then
        cat <<'EOF' > "/etc/tmux.conf"
set-option -g status-style "bg=black,fg=gold"
EOF
fi

# Path_Filtering
for i in $(find /home -maxdepth 1 -type d ! -path "/home" | grep -v "lost+found") "/root"; do
        PATH_BSH="$i/.bashrc"
        PATH_SCREEN="$i/.screenrc"
        PATH_ALIAS="$i/.bash_aliases"
        PATH_VIM="$i/.vimrc"
        PATH_ZSH="$i/.zshrc"
	PATH_Terminal="$i/.config/qterminal.org/qterminal.ini"
        PATH_BloodHound="$i/.config/bloodhound"

        if [[ $Switch_Cargo == true ]]; then
                sudo cp -r "$HOME/.cargo" "$i" &>/dev/null
                sudo chown -R "$(echo "$i" | rev | cut -d '/' -f1 | rev)": "$i/.cargo"
        fi

        if [[ $Switch_BloodHound == true ]]; then
                # UNDER CONSTRUCTION
                ""
        fi

        if [[ $Switch_CUSTOM_CONFIGS == true ]]; then
                # ZSH_Terminal_and_Alias_Configuration (Thx to @HomeSen for the aliases until function b64 and sslyze)
                sudo sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" "$PATH_BSH" &>/dev/null
                sudo sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" "$PATH_ZSH" &>/dev/null
                sudo sed -i s/"^TerminalTransparency=.*/TerminalTransparency=0"/g  "$PATH_Terminal" &>/dev/null
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "$PATH_ALIAS" "$OPT_Path" "$FULL_PATH"
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "$PATH_BSH" "$OPT_Path" "$FULL_PATH"
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "$PATH_ZSH" "$OPT_Path" "$FULL_PATH"
        fi

        if [[ $Switch_SCREENRC_HOMESEN == true ]]; then
                # Screen_Configuration (Thx to @HomeSen)
                cat <<'EOF' > "$PATH_SCREEN"
hardstatus on
hardstatus alwayslastline
hardstatus string "%{.bW}%-w%{.rW}%n %t%{-}%+w %=%{..G} %Y-%m-%d %c "
EOF
        elif [[ $Switch_SCREENRC_BJOERN == true ]]; then
                cat <<'EOF' > "$PATH_SCREEN"
hardstatus on
hardstatus alwayslastline
hardstatus string '%{= kG}[ %{G}%H %{g}][%= %{= kw}%?%-Lw%?%{r}(%{W}%n*%f%t%?(%u)%?%{r})%{w}%?%+Lw%?%?%= %{g}][%{B} %Y-%m-%d %{W}%c %{g}]'

# Turn_Off_Startup_Message
startup_message off
EOF
        fi

        if [[ $Switch_VIM_HOMESEN == true ]]; then
                # Vim_Configuration (Thx to @HomeSen)
                cat <<'EOF' > "$PATH_VIM"
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
        elif [[ $Switch_VIM_NAYANINGALOO == true ]]; then
                cd /tmp/vim || return 0 ; sudo cp -r .vim "$i" ; sudo cp .vimrc .gitmodules "$i"
        fi
done

if [[ $category_type = "pentest" || $category_type = "4" || $category_type = "complete" || $category_type = "1" ]]; then
        # Git_Tools_Installation
        if [ -f "$OPT_Path/PEASS-ng/metasploit/peass.rb" ]; then
                sudo cp "$OPT_Path"/PEASS-ng/metasploit/peass.rb /usr/share/metasploit-framework/modules/post/multi/gather/
        fi

        # Categories_Sort
#        cd "$OPT_Path" || return 0
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"nmap-erpscan","pysap","PyRFC","SAP_GW_RCE_exploit","SAP_RECON"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/Webscanner/SAP
#                mv nmap-erpscan pysap PyRFC SAP_GW_RCE_exploit SAP_RECON "$OPT_Path"/Webscanner/SAP || sudo rm -rf nmap-erpscan pysap PyRFC SAP_GW_RCE_exploit SAP_RECON
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"drupwn","droopescan","CMSmap","ac-drupal"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/Webscanner/Drupal
#                mv drupwn droopescan CMSmap ac-drupal "$OPT_Path"/Webscanner/Drupal || sudo rm -rf drupwn droopescan CMSmap ac-drupal
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"Typo3Scan","T3Scan"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/Webscanner/Typo3 ; mv Typo3Scan T3Scan "$OPT_Path"/Webscanner/Typo3 || sudo rm -rf Typo3Scan T3Scan
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"wpscan","wphunter","WPSeku","Wordpresscan"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/Webscanner/Wordpress
#                mv wpscan wphunter Wordpresscan WPSeku "$OPT_Path"/Webscanner/Wordpress || sudo rm -rf wpscan wphunter Wordpresscan WPSeku
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"joomscan","joomlavs"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/Webscanner/Joomla ; mv joomscan joomlavs "$OPT_Path"/Webscanner/Joomla || sudo rm -rf joomscan joomlavs
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"moodlescan","mooscan","badmoodle"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/Webscanner/Moodle
#                mv moodlescan badmoodle mooscan "$OPT_Path"/Webscanner/Moodle || sudo rm -rf moodlescan badmoodle mooscan
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"chisel","mitm_relay","proxychains-ng"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/Proxy
#                mv chisel mitm_relay proxychains-ng "$OPT_Path"/Proxy || sudo rm -rf chisel mitm_relay proxychains-ng
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"SIPTools","viproy-voipkit"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/SIP ; mv viproy-voipkit SIPTools "$OPT_Path"/SIP || sudo rm -rf viproy-voipkit SIPTools
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"ffuf","wfuzz"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/Fuzzer ; mv ffuf wfuzz "$OPT_Path"/Fuzzer || sudo rm -rf ffuf wfuzz
#        fi
#        if [[ $(/usr/bin/ls "$OPT_Path"/{"Postman","swagger-ui","jwt_tool"} 2>/dev/null) ]]; then
#                sudo mkdir -p "$OPT_Path"/API ; mv Postman swagger-ui jwt_tool "$OPT_Path"/API || sudo rm -rf Postman swagger-ui jwt_tool
#        fi
#        if [[ -d "$OPT_Path/plown" ]]; then
#                sudo mkdir -p "$OPT_Path"/Webscanner/Plone ; mv plown "$OPT_Path"/Webscanner/Plone || sudo rm -rf plown
#        fi
#        if [[ -d "$OPT_Path/LiferayScan" ]]; then
#                sudo mkdir -p "$OPT_Path"/Webscanner/Liferay ; mv LiferayScan "$OPT_Path"/Webscanner/Liferay || sudo rm -rf LiferayScan
#        fi

        # Metasploit_Configuration
        sudo systemctl enable --now postgresql &>/dev/null
        sudo msfdb init

        # Linking_Local_Wordlists
        ln -sf /usr/share/wordlists /opt/wordlists/kali_wordlists
fi

# GIT_Updater_Configuration
if [[ ${#Array_GIT_Updater} -gt 0 ]]; then
        if [[ ! $(/usr/bin/ls "$OPT_Path/update.info" 2>/dev/null) ]]; then
                echo "" > "$OPT_Path/update.info"
        fi
        for git_tool in "${Array_GIT_Updater[@]}"; do
                if [[ ! $(grep "$git_tool" "$OPT_Path/update.info") =~ $git_tool ]]; then
                        find "$OPT_Path" -maxdepth 1 -name "$git_tool" | head -n 1 >> "$OPT_Path/update.info"
                fi
        done
        for git_wordlist in $(find /opt/wordlists -maxdepth 1 ! -path /opt/wordlists | grep -v -E "kali_wordlists|.txt"); do
                if [[ ! $(grep "$git_wordlist" "$OPT_Path/update.info") =~ $git_wordlist ]]; then
                        echo "$git_wordlist" >> "$OPT_Path/update.info"
                fi
        done
fi

# Cargo_Updater_Configuration
if [[ ${#Array_Cargo_Updater} -gt 0 ]]; then
        if [[ ! $(/usr/bin/ls "$OPT_Path/update_cargo.info" 2>/dev/null) ]]; then
                echo "" > "$OPT_Path/update_cargo.info"
        fi
        for cargo_tool in "${Array_Cargo_Updater[@]}"; do
                if [[ ! $(grep "$cargo_tool" "$OPT_Path/update_cargo.info") =~ $cargo_tool ]]; then
                        echo "$cargo_tool" >> "$OPT_Path/update_cargo.info"
                fi
        done
fi

if [[ $decision = "full" || $decision = "1" || $category_type = "complete" || $category_type = "1" ]]; then
        if [[ -f $(find "$OPT_Path/veracrypt" -maxdepth 1 ! -path "$OPT_Path" 2>/dev/null | grep "setup-gui-x64") ]]; then
                if [[ $Switch_License == true ]]; then
                        sudo python3 "$FULL_PATH/Resources/Python/auto.py" Veracrypt "$(find "$OPT_Path/veracrypt" -maxdepth 1 ! -path "$OPT_Path" | grep "setup-gui-x64")"
                else
                        sudo bash "$(find "$OPT_Path/veracrypt" -maxdepth 1 ! -path "$OPT_Path" | grep "setup-gui-x64")"
                fi
                for veracrypt_file in $(find "$OPT_Path/veracrypt" -maxdepth 1 ! -path "$OPT_Path" 2>/dev/null | grep "setup"); do sudo rm -f "$veracrypt_file"; done
        fi
        if [[ $category_type = "pentest" || $category_type = "4" ]]; then
                ln -sf "$OPT_Path/API/Postman/app/Postman" /usr/local/bin/postman
                if [[ $(find "$OPT_Path" -maxdepth 1 ! -path "$OPT_Path" -name "*.xpi") ]]; then
                        if [[ $Switch_License == true ]]; then
                                sudo python3 "$FULL_PATH/Resources/Python/auto.py" Firefox "$OPT_Path" "True"
                        else
                                sudo python3 "$FULL_PATH/Resources/Python/auto.py" Firefox "$OPT_Path" "False"
                        fi
                fi
        fi
fi

# Check_For_Custom_Scripts
if [[ ${#PATH_Install_Dir} -gt 1 ]]; then
	sudo python3 "$FULL_PATH/Resources/Python/install.py" "$PATH_Install_Dir"
fi

if [[ $Switch_Skip_Hardening != true ]]; then
        if [[ $Switch_Hardening = true ]]; then
                for i in "${Array_HARDENING[@]}"; do
                        if [[ $i =~ "#" ]]; then
                                LEN_SYSCTL=$(grep "$i" /etc/sysctl.conf)
                        else
                                LEN_SYSCTL=$(grep "$i" /etc/sysctl.conf | grep -v '#')
                        fi
                        if [[ ! ${#LEN_SYSCTL} -gt 0 ]]; then
                                cat <<EOF >> /etc/sysctl.conf
$i
EOF
                        fi
                done
                sudo sysctl --system
        fi

        # SMB_Hardening
        if [[ $Switch_SMB = true ]]; then
                 sudo mv /etc/samba/smb.conf /etc/samba/smb.bak
		 sudo systemctl disable smbd nmbd
                 cat <<EOF > /etc/samba/smb.conf
[global]
        # Standard
        workgroup = XXXXXXX
        server string = --
        netbios name = --
        security = user
        map to guest = never

        # Network
        dns proxy = no
        interfaces = 127.0.0.1, $SMB_IP_Addresses
        bind interfaces only = yes
        hosts allow localhost, $SMB_Hosts
        smb ports = 445

        # Encryption
        client min protocol = SMB3
        client signing = required
        min protocol = SMB3
        server signing = required

        # Security
        browseable = no
        deadtime = 15
        disable netbios = yes
        guest ok = no
        invalid users = root
        keep alive = 30
        max connections = 1
        restrict anonymous = 2
        usershare allow guests = no
        usershare max shares = 0
        unix password sync = no

        # Logging
        max log size = 1024

[$SMB_Share_Name]
        path = $SMB_Share_Path
        valid users = $SMB_Valid_Users
        writable = no
        read only = yes
EOF
        fi

        # Apache_Configuration
        if [[ $Switch_APACHE = true ]]; then
                if [[ $(apt-cache policy apache2 | grep "Installed" | cut -d ":" -f2) != "(none)" ]]; then
                        sudo a2enmod headers rewrite ssl ; sudo rm -f /var/www/html/index.html ; sudo mkdir -p /etc/apache2/ssl
                        sudo openssl req -nodes -x509 -newkey rsa:2048 -keyout /etc/apache2/ssl/pentest-key.pem -out /etc/apache2/ssl/pentest-cert.pem -sha512 -days 365 -subj '/CN=pentest-kali'
                        if ! grep -q "#Listen 80" /etc/apache2/ports.conf; then
                            sudo sed -i "s/Listen 80/#Listen 80/g" /etc/apache2/ports.conf
                        fi
                        sudo sed -i "s/Options FollowSymLinks/Options None/g" /etc/apache2/apache2.conf
                        sudo sed -i "s/Options Indexes FollowSymLinks/Options None/g" /etc/apache2/apache2.conf
                        if ! grep -qE "ServerSignature Off|ServerTokens Prod|TraceEnable off|FileETag None" /etc/apache2/apache2.conf; then
                                cat <<EOF >> /etc/apache2/apache2.conf
# Method_Options
TraceEnable off

# Information_Options
FileETag None
ServerSignature Off
ServerTokens Prod
EOF
                        fi
                        cat <<EOF > /etc/apache2/sites-available/001-pentest.conf
<VirtualHost $IP_INT:443>
EOF
                        cat <<'EOF' >> /etc/apache2/sites-available/001-pentest.conf
        DocumentRoot /var/www/html

        # SSL_Config
        SSLEngine on
        SSLCertificateFile /etc/apache2/ssl/pentest-cert.pem
        SSLCertificateKeyFile /etc/apache2/ssl/pentest-key.pem

        # Header_Settings
        Header edit Set-Cookie ^(.*)$ "$1; HttpOnly; Secure; SameSite=Lax"
        Header always set Content-Security-Policy "default-src 'self'"
        Header always set Referrer-Policy "strict-origin"
        Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
        Header always set X-Content-Type-Options "nosniff"
        Header always set X-Frame-Options "DENY"
        Header always set X-XSS-Protection "0"

        # Rewrite_Rules
        RewriteEngine On
        RewriteCond %{THE_REQUEST} !HTTP/1.1$
        RewriteCond %{REQUEST_METHOD} ^(HEAD|POST|TRACE|TRACK|OPTIONS|PUT)
        RewriteRule .* - [F]

        # Cipher_Settings
        #SSLCipherSuite HIGH:!MEDIUM:!aNULL:!MD5:!RC4
        SSLCipherSuite ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384
        SSLHonorCipherOrder on
        SSLProtocol +TLSv1.2 +TLSv1.3

        # Directories
        <Directory />
            <LimitExcept POST OPTIONS TRACE TRACK HEAD PUT>
                deny from all
            </LimitExcept>
            Options None
        </Directory>

        # Logging_Options
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
                        cd /etc/apache2/sites-available || return 0 ; a2ensite 001-pentest.conf
                fi
        fi

	# nginx_Configuration
        if [[ $Switch_NGINX = true ]]; then
                if [[ $(apt-cache policy nginx | grep "Installed" | cut -d ":" -f2) != "(none)" ]]; then
                        sudo rm -f /usr/share/nginx/html/index.html /var/www/html/index.nginx-debian.html ; sudo sed -i "s/# server_tokens off;/server_tokens off;/g" /etc/nginx/nginx.conf
                        sudo mkdir -p /etc/nginx/ssl
                        sudo openssl req -nodes -x509 -newkey rsa:2048 -keyout /etc/nginx/ssl/pentest-key.pem -out /etc/nginx/ssl/pentest-cert.pem -sha512 -days 365 -subj '/CN=pentest-kali'
                        sudo sed -i "s/ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE/ssl_protocols TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE/g" /etc/nginx/nginx.conf
                        cat <<EOF > /etc/nginx/conf.d/001-pentest.conf
server {
    listen $IP_INT:443 ssl http2;

EOF
                        cat <<'EOF' >> /etc/nginx/conf.d/001-pentest.conf
    # SSL_Options
    ssl_certificate /etc/nginx/ssl/pentest-cert.pem;
    ssl_certificate_key /etc/nginx/ssl/pentest-key.pem;
    ssl_session_timeout 10m;
    ssl_session_cache off;

    # Cipher_Suites
    ssl_ciphers ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384;
    ssl_prefer_server_ciphers on;

    # Root_Directory
    root /var/www/html;

    # Header_Configuration
    add_header Set-Cookie "Path=/; HttpOnly; Secure; SameSite=Lax";
    add_header Content-Security-Policy "default-src 'self'";
    add_header Referrer-Policy "strict-origin";
    add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload';
    add_header X-Content-Type-Options "nosniff";
    add_header X-Frame-Options "DENY";
    add_header X-XSS-Protection "0";

    # Security_Options
    if ($request_method ~ ^(HEAD|POST|TRACE|TRACK|OPTIONS|PUT)$) {
        return 405;
    }

    # Directories
    location / {
        try_files $uri /index.php?$args;
    }
}
EOF
                fi
        fi

        # Firewall_Configuration
        if [[ $Switch_Firewall = true ]]; then
                if [ -f /etc/iptables/rules.v4 ]; then
                        sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/etc/iptables/rules.v4"
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
# -A INPUT -i eth2 -s 123.123.123.123/32 -p tcp --dport 4444 -j ACCEPT -m comment --comment "Reverse Shell 4444/tcp
# Commit all changes
COMMIT
# Completed on $(date +'%m/%d/%Y %H:%M:%S')
EOF
                fi

                if [ -f /etc/iptables/rules.v6 ]; then
                        sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/etc/iptables/rules.v6"
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
                sudo systemctl enable --now netfilter-persistent.service &>/dev/null
        fi

        # SSH_Configuration
        if [[ $Switch_SSH = true ]]; then
                sudo sed -i "s/#ListenAddress 0.0.0.0/ListenAddress $IP_INT:22/g" /etc/ssh/sshd_config
                sudo sed -i "s/#LogLevel INFO/LogLevel VERBOSE/g" /etc/ssh/sshd_config
                sudo sed -i "s/#MaxAuthTries 6/MaxAuthTries 6/g" /etc/ssh/sshd_config
                sudo sed -i "s/#UseDNS no/UseDNS no/g" /etc/ssh/sshd_config
                sudo sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
                sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
                if ! grep -q "DebianBanner no" /etc/ssh/sshd_config; then
                        cat <<EOF >> /etc/ssh/sshd_config

# Disable OS-Banner
DebianBanner no

EOF
                fi
                IFS=""
                for Cipher in "${Array_SSH_Ciphers[@]}"; do
                        if ! grep -qe "$Cipher" /etc/ssh/sshd_config; then
                                cat <<EOF >> /etc/ssh/sshd_config
$Cipher
EOF
                        fi
                done
                sudo systemctl restart ssh.service
        fi
fi

# Unpacking_Rockyou
if [ -f "/usr/share/wordlists/rockyou.txt.gz" ]; then
        sudo gunzip /usr/share/wordlists/rockyou.txt.gz || yes Y | sudo gunzip /usr/share/wordlists/rockyou.txt.gz
fi

# Docker_Standard_Images
if [[ "$Switch_Skip_Installation" == false ]]; then
	if grep -q nessus "$File_Path" 2>/dev/null || [ "$category_type" = "complete" ] || [ "$category_type" = "1" ]; then
	        if docker ps -a | grep -q nessus; then
	                NESSUS_DOCKER_TEMP=$(docker ps -a | grep "nessus" | cut -d " " -f1)
	                sudo docker stop "$NESSUS_DOCKER_TEMP" ; sleep 1 ; sudo docker rm "$NESSUS_DOCKER_TEMP"
	        fi
	        sudo docker run -d -p 127.0.0.1:8834:8834 --name nessus tenableofficial/nessus
	fi
	if [[ $category_type = "pentest" || $category_type = "4" || $category_type = "complete" || $category_type = "1" || $category_type = "red_teaming" || $category_type = "7" ]]; then
	        if [[ $decision = "full" || $decision = "1" || $category_type = "complete" || $category_type = "1" ]]; then
	                echo -e "\n${CYAN}---------------------------------------------------------------------------------${NOCOLOR}" ; File_Reader "$Informational"
	        fi
	fi
 fi

# VNC_Cert
if [[ ! -d "/opt/ssl" ]]; then
    sudo mkdir -p /opt/ssl
fi
sudo openssl req -nodes -x509 -newkey rsa:2048 -keyout /opt/ssl/pentest-key.pem -out /opt/ssl/pentest-cert.pem -sha512 -days 365 -subj '/CN=pentest-kali' 2>/dev/null

sudo python3 "$FULL_PATH/Resources/Python/clean.py" "$OPT_Path"
Change_Hostname "$HOST_Pentest"
echo -e "\n${CYAN}---------------------------------------------------------------------------------${NOCOLOR}\n"
echo -e "          The following paths was generated by Yggdrasil"
echo -e "\n${CYAN}---------------------------------------------------------------------------------${NOCOLOR}\n"
echo -e "       Toolpath:                         ${ORANGE}$OPT_Path${NOCOLOR}"
echo -e "       Hashcat-Rules:                    ${ORANGE}/opt/hashcat_rules${NOCOLOR}"
echo -e "       Wordlists:                        ${ORANGE}/opt/wordlists${NOCOLOR}"
echo -e "\n${CYAN}---------------------------------------------------------------------------------${NOCOLOR}\n               ${ORANGE}The installation was successful! :)${NOCOLOR}"
if [[ $Switch_Skip_URLS == false && $Switch_URL != false ]]; then
        sleep 3
        if [[ ${#Array_URL} -gt 0 ]]; then
                for URL in "${Array_URL[@]}"; do
                        sudo python3 "$FULL_PATH/Resources/Python/browse.py" "$URL" &> /dev/null 
                done
        fi
fi
