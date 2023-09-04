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
Shredding_DAYS=""
Skip=false
Switch_APACHE=false
Switch_BRANCH=false
Switch_Cargo=false
Switch_CRON=false
Switch_CUSTOM_CONFIGS=false
Switch_Firewall=false
#Switch_FTP=false
Switch_Hardening=false
Switch_IGNORE=false
Switch_License=false
Switch_NGINX=false
Switch_REPO=false
Switch_SCREENRC=false
Switch_SCREENRC_HOMESEN=false
Switch_SCREENRC_BJOERN=false
Switch_SHREDDER=false
Switch_Skip_Configs=false
Switch_Skip_Hardening=false
Switch_Skip_URLS=false
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

declare -a Array_Complete_Install=("$FULL_PATH/Config/Linux/Forensic/full.txt"
"$FULL_PATH/Config/Linux/Cloud/full.txt"
"$FULL_PATH/Config/Linux/Hardening/full.txt"
"$FULL_PATH/Config/Linux/Pentest/Infrastructure/full.txt"
"$FULL_PATH/Config/Linux/Pentest/IOT/full.txt"
"$FULL_PATH/Config/Linux/Pentest/Mobile/full.txt"
"$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Active_Directory/full.txt"
"$FULL_PATH/Config/Linux/Pentest/Red_Teaming/OSINT/full.txt"
"$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Phishing/full.txt"
"$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Physical_Pentesting/full.txt"
"$FULL_PATH/Config/Linux/Pentest/Web/full.txt")

declare -a Array_Filter_Download=("/usr/bin/veracrypt"
"/usr/bin/code"
"/usr/bin/google-chrome"
"/opt/pentest_tools/Proxy/mitmproxy"
"/opt/pentest_tools/kerbrute"
"/opt/pentest_tools/JuicyPotato"
"/opt/pentest_tools/RoguePotato"
"/opt/pentest_tools/Snaffler"
"/opt/pentest_tools/LaZagne"
"/opt/pentest_tools/API/Postman")

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
"/opt/pentest_tools/Webscanner/Liferay/LiferayScan"
"/opt/pentest_tools/Proxy/chisel"
"/opt/pentest_tools/Proxy/mitmproxy"
"/opt/pentest_tools/Proxy/mitm_relay"
"/opt/pentest_tools/Proxy/proxychains-ng"
"/opt/pentest_tools/SIP/viproy-voipkit"
"/opt/pentest_tools/SIP/SIPTools"
"/opt/pentest_tools/SIP/sipvicious"
"/opt/pentest_tools/Fuzzer/ffuf"
"/opt/pentest_tools/Fuzzer/wfuzz"
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

declare -a Array_Pentesting=()

declare -a Array_SSH_Ciphers=("# Keyexchange algorithms"
"KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256"
"# Host-key algorithms"
"HostKeyAlgorithms ssh-ed25519"
"# Encryption algorithms (ciphers)"
"Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com"
"# Message authentication code (MAC) algorithms"
"MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com")

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
        echo -e "💀\t\t\t  ${NORANGE}Version ${CYAN}0.9${NOCOLOR}${NORANGE}b${NOCOLOR}   \t\t\t💀"
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
                echo -e "${CYAN}|${NOCOLOR}   [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}    :  installation of all       toolkits       ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${CYAN}2${NOCOLOR}] ${CYAN}custom${NOCOLOR}      :  installation of custom    tools          ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}3${NOCOLOR}] ${GREEN}forensic${NOCOLOR}    :  installation of forensic  tools          ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}4${NOCOLOR}] ${ORANGE}pentest${NOCOLOR}     :  installation of pentest   tools          ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${BLUE}5${NOCOLOR}] ${BLUE}hardening${NOCOLOR}   :  installation of hardening tools          ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${PURPLE}6${NOCOLOR}] ${PURPLE}training${NOCOLOR}    :  installation of training  tools          ${CYAN}|${NOCOLOR}"
		#echo -e "${CYAN}|${NOCOLOR}   [${RED}7${NOCOLOR}] ${RED}source_code_analysis${NOCOLOR}    :  installation of sca  tools          ${CYAN}|${NOCOLOR}"
		#echo -e "${CYAN}|${NOCOLOR}   [${CYAN}8${NOCOLOR}] ${PURPLE}reverse_engineering${NOCOLOR}    :  installation of reverse engineering  tools          ${CYAN}|${NOCOLOR}"
  		#echo -e "${CYAN}|${NOCOLOR}   [${GREEN}9${NOCOLOR}] ${PURPLE}exploit_development${NOCOLOR}    :  installation of exploit development  tools          ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "installation" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}1${NOCOLOR}] ${GREEN}full${NOCOLOR}         :     full    installation (${GREEN}GUI${NOCOLOR})           ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}2${NOCOLOR}] ${ORANGE}minimal${NOCOLOR}      :     minimal installation (${ORANGE}CLI${NOCOLOR})           ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "pentesting_category" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}1${NOCOLOR}] ${GREEN}infrastructure${NOCOLOR}  :   tools for infra  pentesting         ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}2${NOCOLOR}] ${ORANGE}iot${NOCOLOR}             :   tools for iot    pentesting         ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${BLUE}3${NOCOLOR}] ${BLUE}mobile${NOCOLOR}          :   tools for mobile pentesting         ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${RED}4${NOCOLOR}] ${RED}red_teaming${NOCOLOR}     :   tools for red    teaming            ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${CYAN}5${NOCOLOR}] ${CYAN}web${NOCOLOR}             :   tools for web    pentesting         ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${PURPLE}6${NOCOLOR}] ${PURPLE}cloud${NOCOLOR}           :   tools for cloud  pentesting         ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "red_team" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}            :   complete configuration          ${CYAN}|${NOCOLOR}"
		echo -e "${CYAN}|${NOCOLOR}   [${PURPLE}2${NOCOLOR}] ${PURPLE}active_directory${NOCOLOR}    :   tools for Active Directory      ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${CYAN}3${NOCOLOR}] ${CYAN}osint${NOCOLOR}               :   tools for OSINT                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}4${NOCOLOR}] ${GREEN}phishing${NOCOLOR}            :   tools for phishing              ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}5${NOCOLOR}] ${ORANGE}physical${NOCOLOR}            :   tools for physical tests        ${CYAN}|${NOCOLOR}"
        elif [ "$1" = "hardening" ]; then
                echo -e "${CYAN}|${NOCOLOR}   [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}         :   complete configuration             ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${CYAN}2${NOCOLOR}] ${CYAN}firewall${NOCOLOR}         :   firewall configuration             ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${GREEN}3${NOCOLOR}] ${GREEN}sysctl (OS)${NOCOLOR}      :   sysctl   hardening                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${ORANGE}4${NOCOLOR}] ${ORANGE}ssh${NOCOLOR}              :   SSH      hardening                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${BLUE}5${NOCOLOR}] ${BLUE}apache${NOCOLOR}           :   Apache   hardening                 ${CYAN}|${NOCOLOR}"
                echo -e "${CYAN}|${NOCOLOR}   [${PURPLE}6${NOCOLOR}] ${PURPLE}nginx${NOCOLOR}            :   nginx    hardening                 ${CYAN}|${NOCOLOR}"
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

        input=$1
        while IFS= read -r line
        do
                if [[ $line = "# APT" ]]; then
                        if [[ "$Switch_Verbose" == false ]]; then
                                 Command="sudo DEBIAN_FRONTEND=noninteractive apt install -y" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false
                        else
                                 Command="sudo apt install -y" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false
                        fi
                elif [[ $line = "# Cargo" ]]; then
                        Command="cargo install" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false
                elif [[ $line = "# Docker" ]]; then
                        Command="docker pull" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false
                elif [[ $line = "# Python" ]]; then
                        Command="pip3 install" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false
                elif [[ $line = "# Git" ]]; then
                        Command="git clone" ; Skip=true ; mkdir -p "$2" ; cd "$2" || return 0 ; Switch_WGET=false ; Switch_BRANCH=false
                elif [[ $line = "# Git_Branch" ]]; then
                        Command="git clone -b" ; Skip=true ; mkdir -p "$2" ; cd "$2" || return 0 ; Switch_WGET=false; Switch_BRANCH=true
                elif [[ $line = "# Git_Submodules" ]]; then
                        Command="git clone --recurse-submodules" ; Skip=true ; mkdir -p "$2" ; cd "$2" || return 0 ; Switch_WGET=false
                elif [[ $line = "# Gem" ]]; then
                        Command="gem install" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false
                elif [[ $line = "# Go" ]]; then
                        Command="go get" ; Skip=true ; Switch_WGET=false ; Switch_BRANCH=false
                elif [[ $line = "# Wordlists" ]]; then
                        Command="git clone" ; Skip=true ; mkdir -p /opt/wordlists ; cd /opt/wordlists || return 0 ; Switch_WGET=false ; Switch_BRANCH=false
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
                                                        if [[ $Switch_IGNORE = false ]]; then
                                                                if [[ $Command =~ "apt" ]]; then
                                                                        SECOND_Command="$Command $line || (apt --fix-broken install -y && $Command $line)"
                                                                        if [[ "$(apt-cache policy $line | head -n2 | grep "[0-9]" | awk '{print $2}')" ]]; then
                                                                            echo -e "${RED}$line${NOCOLOR} is already installed."
	                                                                else
                                                                            eval "$SECOND_Command"
									fi
								elif [[ $Command =~ "git clone -b" ]]; then
                                                                        FILE_URL=$(echo "$line" | cut -d" " -f1)
                                                                        FILE_BRANCH=$(echo "$line" | cut -d" " -f2)
									eval "$Command $FILE_BRANCH $FILE_URL"
								elif [[ $Command =~ "cargo" ]]; then
     									eval "$Command $line" || source "$HOME/.cargo/env" && eval "$Command $line"
                                                                else
                                                                        eval "$Command $line"
                                                                fi
                                                                Logger "$Command" "$line"
                                                        else
                                                                echo -e "${RED}$line${NOCOLOR} already exists." | tee -a "$FULL_PATH/yggdrasil.log"
                                                        fi
                                                fi
                                        else
                                                if [[ $Switch_IGNORE = false ]]; then
							if [[ $Command =~ "apt" ]]; then
								SECOND_Command="$Command $line || (apt --fix-broken install -y && $Command $line)"
								eval "$SECOND_Command"
							elif [[ $Command =~ "git clone -b" ]]; then
								FILE_URL=$(echo "$line" | cut -d" " -f1)
								FILE_BRANCH=$(echo "$line" | cut -d" " -f2)
								eval "$Command $FILE_BRANCH $FILE_URL"
							else
								eval "$Command $line"
							fi
							Logger "$Command" "$line"
                                                else
                                                        echo -e "${RED}$line${NOCOLOR} already exists." | tee -a "$FULL_PATH/yggdrasil.log"
                                                fi
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
                                                if [ "$MODE" = "Executeable" ]; then
                                                        mkdir -p "$2"/"$FILE_NAME" ; cd "$2"/"$FILE_NAME" || return 0
                                                        wget "$FILE" -O "$FILE_NAME"
                                                        chmod +x "$FILE_NAME" ; cd "$2" || return 0
                                                elif [ "$MODE" = "Archive" ]; then
                                                        wget --content-disposition "$FILE"
                                                        FILE_NAME=$(curl -L --head -s "$FILE" | grep filename | cut -d "=" -f2)
                                                        if [[ ${#FILE_NAME} -gt 0 ]]; then
                                                                sudo python3 "$FULL_PATH/Resources/Python/zip.py" "$FILE_NAME" "$2"
                                                        else
                                                                sudo python3 "$FULL_PATH/Resources/Python/zip.py" "$FILE" "$2"
                                                        fi
                                                elif [ "$MODE" = "Installer" ]; then
                                                        wget --content-disposition "$FILE"
                                                        FILE_NAME=$(curl -L --head -s "$FILE" | grep filename | cut -d "=" -f2)
                                                        if [[ $FILE_NAME =~ "rustup" ]]; then
								sudo bash "$2"/"$(echo "$FILE_NAME" | cut -d '"' -f2)" -y | tee -a "$FULL_PATH/yggdrasil.log"
								if [[ -d "/root/.cargo" ]]; then
									Switch_Cargo=true
								fi
								source "$HOME/.cargo/env"
                                                        else
                                                                sudo bash "$2"/"$(echo "$FILE_NAME" | cut -d '"' -f2)" | tee -a "$FULL_PATH/yggdrasil.log"
                                                        fi
                                                elif [ "$MODE" = "Extension" ]; then
                                                        wget --content-disposition "$FILE"
                                                        FILE_NAME=$(curl -L --head -s "$FILE" | grep filename | cut -d "=" -f2)
                                                elif [ "$MODE" = "DPKG" ]; then
                                                        FILE_NAME=$(curl -L --head -s "$FILE" | grep filename | cut -d "=" -f2)
                                                        if [[ ${#FILE_NAME} -gt 0 ]]; then
                                                                wget --content-disposition "$FILE"
                                                                sudo dpkg -i "$2"/"$(echo "$FILE_NAME" | cut -d '"' -f2)" | tee -a "$FULL_PATH/yggdrasil.log"
                                                        else
                                                                FILE_NAME=$(echo "$line" | cut -d" " -f2)
                                                                wget "$FILE" -O "$FILE_NAME".deb
                                                                sudo dpkg -i "$2"/"$(echo "$FILE_NAME" | cut -d '"' -f2).deb" | tee -a "$FULL_PATH/yggdrasil.log"
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
                sleep 0.15
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

function Red_Team_Check() {
        red_team=$1
	if [[ $red_team == "complete" || $red_team == "1" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Active_Directory")
              Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming/OSINT")
              Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Phishing")
              Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Physical_Pentesting")
              Array_URL+=("$FULL_PATH/Information/Pages/OSINT.txt")
	elif [[ $red_team == "active_directory" || $red_team == "2" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Active_Directory")
	elif [[ $red_team == "osint" || $red_team == "3" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming/OSINT")
	      Array_URL+=("$FULL_PATH/Information/Pages/OSINT.txt")
	elif [[ $red_team == "phishing" || $red_team == "4" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Phishing")
	elif [[ $red_team == "physical" || $red_team == "5" ]]; then
	      Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming/Physical_Pentesting")
	else
	      echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
	fi
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
        elif [[ $arg == "-sU" ]]; then
                Switch_Skip_URLS=true
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
        fi
done

# Category
header "category"
read -rp "Your Choice: " category_type
if [[ $category_type = "forensic" || $category_type = "3" ]]; then
        Path_Way="$FULL_PATH/Config/Linux/Forensic"
        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
                OPT_Path="/opt/forensic_tools"
        fi
        if [[ $HOST_Pentest == "pentest-kali" ]]; then
                HOST_Pentest="forensic-kali"
        fi
elif [[ $category_type = "pentest" || $category_type = "4" ]]; then
        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
                OPT_Path="/opt/pentest_tools"
        fi
        header "pentesting_category"
        read -rp "Your Choice: " pentesting
        if [[ $pentesting =~ "," ]]; then
                IFS=", "
                Array_Pentesting=($pentesting)
                for testing_category in "${Array_Pentesting[@]}"; do
                        if [[ $testing_category == "infrastructure" || $testing_category == "1" ]]; then
                                Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Infrastructure")
                                Array_URL+=("$FULL_PATH/Information/Pages/Infrastructure.txt")
                        elif [[ $testing_category == "iot" || $testing_category == "2" ]]; then
                                Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/IOT")
                        elif [[ $testing_category == "mobile" || $testing_category == "3" ]]; then
                                Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Mobile")
                        elif [[ $testing_category == "red_teaming" || $testing_category == "4" ]]; then
                                Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Red_Teaming")
                                Array_URL+=("$FULL_PATH/Information/Pages/OSINT.txt")
				header "red_team"
				read -rp "Your Choice: " red_team
				if [[ $red_team =~ "," ]]; then
					IFS=", "
					Array_Red_Teaming=($red_team)
					for testing_category in "${Array_Red_Teaming[@]}"; do
                                            Red_Team_Check $testing_category
					done
				else
                                        Red_Team_Check $red_team
				fi
                        elif [[ $testing_category == "web" || $testing_category == "5" ]]; then
                                Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Web")
                        elif [[ $testing_category == "cloud" || $testing_category == "6" ]]; then
                                Array_Categories+=("$FULL_PATH/Config/Linux/Pentest/Cloud")
                        else
                                echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
                        fi
                done
        else
                if [[ $pentesting = "infrastructure" || $pentesting = "1" ]]; then
                        Path_Way="$FULL_PATH/Config/Linux/Pentest/Infrastructure"
                        Array_URL+=("$FULL_PATH/Information/Pages/Infrastructure.txt")
                elif [[ $pentesting = "iot" || $pentesting = "2" ]]; then
                        Path_Way="$FULL_PATH/Config/Linux/Pentest/IOT"
                elif [[ $pentesting = "mobile" || $pentesting = "3" ]]; then
                        Path_Way="$FULL_PATH/Config/Linux/Pentest/Mobile"
                elif [[ $pentesting = "red_teaming" || $pentesting = "4" ]]; then
			header "red_team"
			read -rp "Your Choice: " red_team
			if [[ $red_team =~ "," ]]; then
				IFS=", "
				Array_Red_Teaming=($red_team)
				for testing_category in "${Array_Red_Teaming[@]}"; do
                                     Red_Team_Check $testing_category
				done
			else
                                Red_Team_Check $red_team
			fi
                elif [[ $pentesting = "web" || $pentesting = "5" ]]; then
                        Path_Way="$FULL_PATH/Config/Linux/Pentest/Web"
                elif [[ $pentesting = "cloud" || $pentesting = "6" ]]; then
                        Path_Way="$FULL_PATH/Config/Linux/Pentest/Cloud"
                else
                        echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
                fi
        fi
elif [[ $category_type = "hardening" || $category_type = "5" ]]; then
        Path_Way="$FULL_PATH/Config/Linux/Hardening"
        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
                OPT_Path="/opt/hardening_tools"
        fi
        Array_URL+=("$FULL_PATH/Information/Pages/Hardening.txt")
elif [[ $category_type = "training" || $category_type = "6" ]]; then
        Path_Way="$FULL_PATH/Config/Linux/Training"
        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
                OPT_Path="/opt/training_tools"
        fi
        Array_URL+=("$FULL_PATH/Information/Pages/Education.txt")
elif [[ $category_type = "custom" || $category_type = "2" ]]; then
        Path_Way="$FULL_PATH/Config/Linux/Custom"
        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
                OPT_Path="/opt/custom_yggdrasil_tools"
        fi
elif [[ $category_type = "complete" || $category_type = "1" ]]; then
        if [[ ! "${#OPT_Path}" -gt 2 ]]; then
                OPT_Path="/opt/complete_tools"
        fi
        declare -a Array_URL=("$FULL_PATH/Information/Pages/Infrastructure.txt"
"$FULL_PATH/Information/OSINT.txt"
"$FULL_PATH/Information/Forensic.txt"
"$FULL_PATH/Information/Hardening.txt")
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
        if [[ ${#Array_Categories} -gt 0 ]]; then
                Path_Way="$FULL_PATH/Config/Linux/Pentest/Infrastructure"
                File_Path="${Path_Way}/full.txt"
                Informational="$FULL_PATH/Information/info.txt"
                decision="full"
        else
                if [[ $pentesting = "iot" || $pentesting = "2" || $pentesting = "mobile" || $pentesting = "3" || $pentesting = "web" || $pentesting = "red_teaming" || $pentesting = "4" || $pentesting = "5" || $pentesting = "cloud" || $pentesting = "6" ]]; then
                        File_Path="${Path_Way}/full.txt"
                        decision="full"
                        Informational="$FULL_PATH/Information/info.txt"
                else
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

# Hardening_Configuration
if [[ $Switch_Skip_Hardening != true ]]; then
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
                        fi
                done
        else
                if [[ $hardening = "complete" || $hardening = "1" ]]; then
                        Switch_Firewall=true ; Switch_Hardening=true ; Switch_SSH=true ; Switch_APACHE=true ; Switch_NGINX=true #; Switch_FTP=true ; Switch_SQUID=true
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
                else
                        echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
                fi
        fi
        clearing

        # SSH_Configuration
        if [[ $Switch_SSH != false ]]; then
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
                                echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
                        fi
                        clearing
                else
                        echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
                fi
        fi
else
        clearing
fi

# Settings_Configuration
if [[ $Switch_Skip_Configs != true ]]; then
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
                        echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
                fi
        fi
        clearing
fi

# VIM_Configuration
if [[ $Switch_VIM_CONFIG = true ]]; then
        header "vim"
        read -rp "Your Choice: " vim_settings
        if [[ $vim_settings = "homesen" || $vim_settings = "1" ]]; then
                Switch_VIM_HOMESEN=true
        elif [[ $vim_settings = "nayaningaloo" || $vim_settings = "2" ]]; then
                Switch_VIM_NAYANINGALOO=true
        else
                echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
        fi
        clearing
fi

# Screenrc_Configuration
if [[ $Switch_SCREENRC = true ]]; then
        header "screenrc"
        read -rp "Your Choice: " screenrc_settings
        if [[ $screenrc_settings = "homesen" || $screenrc_settings = "1" ]]; then
                Switch_SCREENRC_HOMESEN=true
        elif [[ $screenrc_settings = "jarl-bjoern" || $screenrc_settings = "2" ]]; then
                Switch_SCREENRC_BJOERN=true
        else
                echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
        fi
        clearing
fi

# Updater_Configuration
if [[ $Switch_UPDATES = true || $Switch_SHREDDER = true ]]; then
        header "task"
        read -rp "Your Choice: " task_settings
        if [[ $task_settings = "cronjob" || $task_settings = "1" ]]; then
                Switch_CRON=true
        elif [[ $task_settings = "timer" || $task_settings = "2" ]]; then
                Switch_SYSTEMD=true
        else
                echo -e "\nYour decision was not accepted!\nPlease try again." ; exit
        fi
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
if [[ "$Switch_Verbose" == false ]]; then
         sudo apt update -y ; sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; sudo apt autoremove -y --purge ; sudo apt clean all
else
         sudo apt update -y ; sudo apt full-upgrade -y ; sudo apt autoremove -y --purge ; sudo apt clean all
fi

# Task_Configuration
if [[ "$Switch_UPDATES" == true ]]; then
        if [[ "$Switch_CRON" == true ]]; then
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/etc/crontab" "$OPT_Path" "normal"
        elif [[ "$Switch_SYSTEMD" == true ]]; then
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/usr/lib/systemd/system" "$OPT_Path"
                sudo systemctl enable --now Yggdrasil_Cargo_Updater.timer Yggdrasil_Container_Cleaner.timer Yggdrasil_Container_Updates.timer Yggdrasil_GIT_Updater.timer Yggdrasil_PIP_Updater.timer Yggdrasil_System_Updates.timer &>/dev/null
                sudo systemctl daemon-reload &>/dev/null
        fi
fi
if [[ "$Switch_SHREDDER" == true ]]; then
        if [[ "$Switch_CRON" == true ]]; then
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/etc/crontab" "$PATH_WORKSPACE" "shred" "$Shredding_DAYS"
        elif [[ "$Switch_SYSTEMD" == true ]]; then
                sudo python3 "$FULL_PATH/Resources/Python/filter.py" "/usr/lib/systemd/system" "$PATH_WORKSPACE" "shred" "$Shredding_DAYS"
                sudo systemctl enable --now Yggdrasil_Workspace_Cleaner.timer &>/dev/null
        fi
fi
sudo systemctl daemon-reload &>/dev/null

# Standard_Installation
if [[ "$Switch_Skip_Hardening" != true ]]; then
        echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
        echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
fi
if [[ $category_type != "custom" && $category_type != "2" ]]; then
        File_Installer "$FULL_PATH/Config/Linux/General/standard.txt" "$OPT_Path"
        if [[ $decision = "full" || $decision = "1" || $category_type = "complete" || $category_type = "1" || ${#Array_Categories} -gt 0 ]]; then
                File_Installer "$FULL_PATH/Config/Linux/General/gui.txt" "$OPT_Path"
        fi
fi

# Tool_Installation
if [[ $category_type = "complete" || $category_type = "1" ]]; then
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
for i in $(find /home -maxdepth 1 ! -path "/home" | grep -v "lost+found") "/root"; do
        PATH_BSH="$i/.bashrc"
        PATH_SCREEN="$i/.screenrc"
        PATH_ALIAS="$i/.bash_aliases"
        PATH_VIM="$i/.vimrc"
        PATH_ZSH="$i/.zshrc"

        if [[ $Switch_Cargo == true ]]; then
                sudo cp -r "$HOME/.cargo" "$i" &>/dev/null
                sudo chown -R "$(echo "$i" | rev | cut -d '/' -f1 | rev)": "$i/.cargo"
        fi

        if [[ $Switch_CUSTOM_CONFIGS == true ]]; then
                # ZSH_and_Alias_Configuration (Thx to @HomeSen for the aliases until function b64)
                sudo sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" "$PATH_BSH" &>/dev/null
                sudo sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" "$PATH_ZSH" &>/dev/null
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
hardstatus string '%{= kG}[ %{G}%H %{g}][%= %{= kw}%?%-Lw%?%{r}(%{W}%n*%f%t%?(%u)%?%{r})%{w}%?%+Lw%?%?%= %{g}][%{B} %m-%d %{W}%c %{g}]'

# Turn_Off_Startup_Message
startup_message off

# Create_Five_Tabs
screen -t vpn
screen -t monitoring
screen -t ssh-kali01
screen -t ssh-kali02
screen -t scp

# Select_First_Tab
select 0
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
        if [ -d "$OPT_Path/chisel" ]; then
                cd "$OPT_Path"/chisel || return 0 ; sudo go get ; sudo go build
        fi
        if [ -d "$OPT_Path/enum4linux-ng" ]; then
                sudo pip3 install -r "$OPT_Path"/enum4linux-ng/requirements.txt
        fi
        if [ -f "$OPT_Path/EyeWitness/Python/setup/setup.sh" ]; then
                sudo bash "$OPT_Path"/EyeWitness/Python/setup/setup.sh ; echo -e "${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
        fi
        if [ -f "$OPT_Path/PEASS-ng/metasploit/peass.rb" ]; then
                sudo cp "$OPT_Path"/PEASS-ng/metasploit/peass.rb /usr/share/metasploit-framework/modules/post/multi/gather/
        fi
        if [ -d "$OPT_Path/ssh_scan" ]; then
                cd "$OPT_Path"/ssh_scan || return 0 ; sudo gem install bundler ; sudo bundle install ; echo -e "${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
        fi
        if [ -d "$OPT_Path/socketcand" ]; then
                cd "$OPT_Path"/socketcand || return 0 ; sudo bash autogen.sh ; sudo ./configure ; sudo make ; sudo make install ; echo -e "${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
        fi
        if [ -d "$OPT_Path/Responder" ]; then
                pip3 install -r "$OPT_Path"/Responder/requirements.txt ; echo -e "${CYAN}-----------------------------------------------------------------${NOCOLOR}\n"
        fi
        if [ -f "$OPT_Path/mitmdump" ]; then
                cd "$OPT_Path" || return 0 ; mv mitmproxy mitmproxy.sh ; sudo mkdir -p "$OPT_Path"/mitmproxy ; mv mitmproxy.sh mitmdump mitmweb mitmproxy/ ; cd mitmproxy/ || return 0 ; mv mitmproxy.sh mitmproxy
        fi

        # Categories_Sort
        cd "$OPT_Path" || return 0
        if [[ $(ls "$OPT_Path"/{"nmap-erpscan","pysap","PyRFC","SAP_GW_RCE_exploit","SAP_RECON"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/Webscanner/SAP
                mv nmap-erpscan pysap PyRFC SAP_GW_RCE_exploit SAP_RECON "$OPT_Path"/Webscanner/SAP || sudo rm -rf nmap-erpscan pysap PyRFC SAP_GW_RCE_exploit SAP_RECON
        fi
        if [[ $(ls "$OPT_Path"/{"drupwn","droopescan","CMSmap","ac-drupal"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/Webscanner/Drupal
                mv drupwn droopescan CMSmap ac-drupal "$OPT_Path"/Webscanner/Drupal || sudo rm -rf drupwn droopescan CMSmap ac-drupal
        fi
        if [[ $(ls "$OPT_Path"/{"Typo3Scan","T3Scan"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/Webscanner/Typo3 ; mv Typo3Scan T3Scan "$OPT_Path"/Webscanner/Typo3 || sudo rm -rf Typo3Scan T3Scan
        fi
        if [[ $(ls "$OPT_Path"/{"wpscan","wphunter","WPSeku","Wordpresscan"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/Webscanner/Wordpress
                mv wpscan wphunter Wordpresscan WPSeku "$OPT_Path"/Webscanner/Wordpress || sudo rm -rf wpscan wphunter Wordpresscan WPSeku
        fi
        if [[ $(ls "$OPT_Path"/{"joomscan","joomlavs"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/Webscanner/Joomla ; mv joomscan joomlavs "$OPT_Path"/Webscanner/Joomla || sudo rm -rf joomscan joomlavs
        fi
        if [[ $(ls "$OPT_Path"/{"moodlescan","mooscan","badmoodle"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/Webscanner/Moodle
                mv moodlescan badmoodle mooscan "$OPT_Path"/Webscanner/Moodle || sudo rm -rf moodlescan badmoodle mooscan
        fi
        if [[ $(ls "$OPT_Path"/{"chisel","mitmproxy","mitm_relay","proxychains-ng"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/Proxy
                mv chisel mitmproxy mitm_relay proxychains-ng "$OPT_Path"/Proxy || sudo rm -rf chisel mitmproxy mitm_relay proxychains-ng
        fi
        if [[ $(ls "$OPT_Path"/{"SIPTools","sipvicious","viproy-voipkit"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/SIP ; mv viproy-voipkit sipvicious SIPTools "$OPT_Path"/SIP || sudo rm -rf viproy-voipkit sipvicious SIPTools
        fi
        if [[ $(ls "$OPT_Path"/{"ffuf","wfuzz"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/Fuzzer ; mv ffuf wfuzz "$OPT_Path"/Fuzzer || sudo rm -rf ffuf wfuzz
        fi
        if [[ $(ls "$OPT_Path"/{"Postman","swagger-ui","jwt_tool"} 2>/dev/null) ]]; then
                sudo mkdir -p "$OPT_Path"/API ; mv Postman swagger-ui jwt_tool "$OPT_Path"/API || sudo rm -rf Postman swagger-ui jwt_tool
        fi
        if [[ -d "$OPT_Path/plown" ]]; then
                sudo mkdir -p "$OPT_Path"/Webscanner/Plone ; mv plown "$OPT_Path"/Webscanner/Plone || sudo rm -rf plown
        fi
        if [[ -d "$OPT_Path/LiferayScan" ]]; then
                sudo mkdir -p "$OPT_Path"/Webscanner/Liferay ; mv LiferayScan "$OPT_Path"/Webscanner/Liferay || sudo rm -rf LiferayScan
        fi

        # Metasploit_Configuration
        sudo systemctl enable --now postgresql &>/dev/null
        sudo msfdb init

        # Linking_Local_Wordlists
        ln -sf /usr/share/wordlists /opt/wordlists/kali_wordlists

        # Custom_Wordlist
        if [[ ! -f "/opt/wordlists/tomcat-directories.txt" ]]; then
                # Copied from https://gist.github.com/KINGSABRI/277e01a9b03ea7643efef8d5747c8f16/tomcat-directory.list
                cat <<'EOF' > /opt/wordlists/tomcat-directories.txt
/admin
/admin-console
/docs/
/examples
/examples/jsp/index.html
/examples/jsp/snp/snoop.jsp
/examples/jsp/source.jsp
/examples/servlet/HelloWorldExample
/examples/servlet/SnoopServlet
/examples/servlet/TroubleShooter
/examples/servlet/default/jsp/snp/snoop.jsp
/examples/servlet/default/jsp/source.jsp
/examples/servlet/org.apache.catalina.INVOKER.HelloWorldExample
/examples/servlet/org.apache.catalina.INVOKER.SnoopServlet
/examples/servlet/org.apache.catalina.INVOKER.TroubleShooter
/examples/servlet/org.apache.catalina.servlets.DefaultServlet/jsp/snp/snoop.jsp
/examples/servlet/org.apache.catalina.servlets.DefaultServlet/jsp/source.jsp
/examples/servlet/org.apache.catalina.servlets.WebdavServlet/jsp/snp/snoop.jsp
/examples/servlet/org.apache.catalina.servlets.WebdavServlet/jsp/source.jsp
/examples/servlet/snoop
/examples/servlets/index.html
/examples/websocket/index.xhtml
/host-manager
/host-manager/add
/host-manager/host-manager.xml
/host-manager/html
/host-manager/html/*
/host-manager/list
/host-manager/remove
/host-manager/start
/host-manager/stop
/invoker/JMXInvokerServlet
/jmx-console
/jmx-console/HtmlAdaptor
/jsp-examples
/manager
/manager/deploy
/manager/html
/manager/html/*
/manager/install
/manager/jmxproxy
/manager/jmxproxy/*
/manager/list
/manager/manager.xml
/manager/reload
/manager/remove
/manager/resources
/manager/roles
/manager/save
/manager/serverinfo
/manager/sessions
/manager/start
/manager/status.xsd
/manager/status/*
/manager/stop
/manager/undeploy
/server-manager/html
/servlet/default/
/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.DefaultServlet/tomcat.gif
/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.SnoopAllServlet
/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.WebdavServlet/
/servlet/org.apache.catalina.servlets.DefaultServlet/
/servlet/org.apache.catalina.servlets.DefaultServlet/tomcat.gif
/servlet/org.apache.catalina.servlets.HTMLManagerServlet
/servlet/org.apache.catalina.servlets.InvokerServlet/org.apache.catalina.servlets.DefaultServlet/tomcat.gif
/servlet/org.apache.catalina.servlets.InvokerServlet/org.apache.catalina.servlets.SnoopAllServlet
/servlet/org.apache.catalina.servlets.ManagerServlet
/servlet/org.apache.catalina.servlets.SnoopAllServlet
/servlet/org.apache.catalina.servlets.WebdavServlet/
/servlets-examples
/status
/tomcat-docs
/tomcat/manager/html
/web-console
/web-console/Invoker
/webdav
/webdav/index.html
/webdav/servlet/org.apache.catalina.servlets.WebdavServlet/
/webdav/servlet/webdav/
EOF
        fi
fi

# GIT_Updater_Configuration
if [[ ${#Array_GIT_Updater} -gt 0 ]]; then
        if [[ ! $(ls "$OPT_Path/update.info" 2>/dev/null) ]]; then
                echo "" > "$OPT_Path/update.info"
        fi
        for git_tool in "${Array_GIT_Updater[@]}"; do
                if [[ ! $(grep "$git_tool" "$OPT_Path/update.info") =~ $git_tool ]]; then
                        find "$OPT_Path" -name "$git_tool" | head -n 1 >> "$OPT_Path/update.info"
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
        if [[ ! $(ls "$OPT_Path/update_cargo.info" 2>/dev/null) ]]; then
                echo "" > "$OPT_Path/update_cargo.info"
        fi
        for cargo_tool in "${Array_Cargo_Updater[@]}"; do
                if [[ ! $(grep "$cargo_tool" "$OPT_Path/update_cargo.info") =~ $cargo_tool ]]; then
                        echo "$cargo_tool" >> "$OPT_Path/update_cargo.info"
                fi
        done
fi

if [[ $decision = "full" || $decision = "1" || $category_type = "complete" || $category_type = "1" ]]; then
        if [[ -f $(find "$OPT_Path" -maxdepth 1 ! -path "$OPT_Path" | grep "setup-gui-x64") ]]; then
                if [[ $Switch_License == true ]]; then
                        sudo python3 "$FULL_PATH/Resources/Python/auto.py" Veracrypt "$(find "$OPT_Path" -maxdepth 1 ! -path "$OPT_Path" | grep "setup-gui-x64")"
                else
                        sudo bash "$(find "$OPT_Path" -maxdepth 1 ! -path "$OPT_Path" | grep "setup-gui-x64")"
                fi
                for veracrypt_file in $(find "$OPT_Path" -maxdepth 1 ! -path "$OPT_Path" | grep "setup"); do sudo rm -f "$veracrypt_file"; done
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
if grep -q nessus "$File_Path" || [ "$category_type" = "complete" ] || [ "$category_type" = "1" ]; then
        if docker ps -a | grep -q nessus; then
                NESSUS_DOCKER_TEMP=$(docker ps -a | grep "nessus" | cut -d " " -f1)
                sudo docker stop "$NESSUS_DOCKER_TEMP" ; sleep 1 ; sudo docker rm "$NESSUS_DOCKER_TEMP"
        fi
        sudo docker run -d -p 127.0.0.1:8834:8834 --name nessus tenableofficial/nessus
fi
if [[ $category_type = "pentest" || $category_type = "4" || $category_type = "complete" || $category_type = "1" ]]; then
        if [[ $decision = "full" || $decision = "1" || $category_type = "complete" || $category_type = "1" ]]; then
                echo -e "\n${CYAN}---------------------------------------------------------------------------------${NOCOLOR}" ; File_Reader "$Informational"
        fi
fi

# VNC_Cert
if [[ ! -d "/opt/ssl" ]]; then
    sudo mkdir -p /opt/ssl
fi
sudo openssl req -nodes -x509 -newkey rsa:2048 -keyout /opt/ssl/pentest-key.pem -out /opt/ssl/pentest-cert.pem -sha512 -days 365 -subj '/CN=pentest-kali' 2>/dev/null

sudo python3 "$FULL_PATH/Resources/Python/clean.py" "$OPT_Path"
Change_Hostname "$HOST_Pentest"
echo -e "\n${CYAN}---------------------------------------------------------------------------------${NOCOLOR}\n                    ${ORANGE}The installation was successful! :)${NOCOLOR}"
if [[ $Switch_Skip_URLS == false && $Switch_URL != false ]]; then
        sleep 3
        if [[ ${#Array_URL} -gt 0 ]]; then
                for URL in "${Array_URL[@]}"; do
                        sudo python3 "$FULL_PATH/Resources/Python/browse.py" "$URL"
                done
        fi
fi
