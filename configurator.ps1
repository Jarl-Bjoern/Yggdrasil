# Rainer Christian Bjoern Herold
# UNDER CONSTRUCTION

# Variables
decision = ""
IP_INT=127.0.0.1
PATH_Install_Dir = ""
pentesting = ""
Skip = false
Switch_Firewall = false
Switch_Hardening = false
Switch_IGNORE = false
Switch_License = false
Switch_SSH = false
Switch_Skip = false
Switch_WGET = false

# Arrays
$Filter_Download = @('C:/Pentest_Tools')

# Functions
function Header {
        clear ; initials
        if ($1 = "category") {
                echo "`n          Please choose between one category"
        } elif ($1 = "installation") {
                echo "`n          Please choose between one installation"
        }
        echo "${CYAN}----------------------------------------------------------${NOCOLOR}"
        echo "${CYAN}|${NOCOLOR}                                                        ${CYAN}|${NOCOLOR}"
        if ($1 = "category") {
                echo "${CYAN}|${NOCOLOR} [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}    :   installation of both toolkits      ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${CYAN}2${NOCOLOR}] ${CYAN}custom${NOCOLOR}      :   installation of custom tools       ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${GREEN}3${NOCOLOR}] ${GREEN}forensic${NOCOLOR}    :   installation of forensic tools     ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${ORANGE}4${NOCOLOR}] ${ORANGE}pentest${NOCOLOR}     :   installation of pentest tools      ${CYAN}|${NOCOLOR}"
        } elif ($1 = "installation") {
                echo "${CYAN}|${NOCOLOR} [${GREEN}1${NOCOLOR}]        ${GREEN}full${NOCOLOR}    : full installation (GUI)           ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${ORANGE}2${NOCOLOR}]        ${ORANGE}minimal${NOCOLOR} : minimal installation (CLI)        ${CYAN}|${NOCOLOR}"
        } elif ($1 = "pentesting_category") {
                echo "${CYAN}|${NOCOLOR} [${GREEN}1${NOCOLOR}] ${GREEN}infrastructure${NOCOLOR}  :   tools for infra pentesting     ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${ORANGE}2${NOCOLOR}] ${ORANGE}iot${NOCOLOR}             :   tools for iot pentesting       ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${BLUE}3${NOCOLOR}] ${BLUE}mobile${NOCOLOR}          :   tools for mobile pentesting    ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${RED}4${NOCOLOR}] ${RED}red_teaming${NOCOLOR}     :   tools for red teaming          ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${CYAN}5${NOCOLOR}] ${CYAN}web${NOCOLOR}             :   tools for web pentesting       ${CYAN}|${NOCOLOR}"
        } elif ($1 = "hardening") {
                echo "${CYAN}|${NOCOLOR} [${RED}1${NOCOLOR}] ${RED}complete${NOCOLOR}         :   complete configuration        ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${CYAN}2${NOCOLOR}] ${CYAN}Firewall${NOCOLOR}         :   firewall                      ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${GREEN}3${NOCOLOR}] ${GREEN}Sysctl (OS)${NOCOLOR}      :   sysctl hardening              ${CYAN}|${NOCOLOR}"
                echo "${CYAN}|${NOCOLOR} [${ORANGE}4${NOCOLOR}] ${ORANGE}SSH${NOCOLOR}              :   SSH hardening                 ${CYAN}|${NOCOLOR}"
        }
        echo "${CYAN}|${NOCOLOR}                                                        ${CYAN}|${NOCOLOR}"
        echo "${CYAN}----------------------------------------------------------${NOCOLOR}`n"
}

function Initials {
        echo "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀"
        echo "💀                                                     💀"
        echo "💀                       Yggdrasil                     💀"
        echo "💀                     Version 0.8                     💀"
        echo "💀           Rainer Christian Bjoern Herold            💀"
        echo "💀                                                     💀"
        echo "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀`n"
}

function Downloader {
        New-Item "C:/Wordlists" -ItemType Directory

        foreach($line in Get-Content "") {
                if ($line -match "") {
                        Invoke-WebRequest "" -OutFile ""
                }
        }
}

# Main
Initials
