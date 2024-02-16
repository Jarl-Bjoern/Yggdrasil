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
        Write-Host "----------------------------------------------------------" -f Cyan
        Write-Host "|                                                        |" -f Cyan
        if ($1 = "category") {
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "1" -f Red -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "complete" -f Red -NoNewLine ; Write-Host "    :   installation of both toolkits      " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "2" -f Cyan -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "custom" -f Cyan -NoNewLine ; Write-Host "      :   installation of custom tools       " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "3" -f Green -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "forensic" -f Green -NoNewLine ; Write-Host "    :   installation of forensic tools     " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "4" -f DarkYellow -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "pentest" -f DarkYellow -NoNewLine ; Write-Host "     :   installation of pentest tools      " -NoNewLine ; Write-Host "|" -f Cyan
        } elif ($1 = "installation") {
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "1" -f Green -NoNewLine ; Write-Host "]        " -NoNewLine ; Write-Host "full" -f Green -NoNewLine ; Write-Host "    : full installation (GUI)           " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "2" -f DarkYellow -NoNewLine ; Write-Host "]        " -NoNewLine ; Write-Host "minimal" -f DarkYellow -NoNewLine ; Write-Host " : minimal installation (CLI)        " -NoNewLine ; Write-Host "|" -f Cyan
        } elif ($1 = "pentesting_category") {
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "1" -f Green -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "infrastructure" -f Green -NoNewLine ; Write-Host "  :   tools for infra pentesting     " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "2" -f DarkYellow -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "iot" -f DarkYellow -NoNewLine ; Write-Host "             :   tools for iot pentesting       " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "3" -f Blue -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "mobile" -f Blue -NoNewLine ; Write-Host "          :   tools for mobile pentesting    " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "4" -f Red -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "red_teaming" -f Red -NoNewLine ; Write-Host "     :   tools for red teaming          " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "5" -f Cyan -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "web" -f Cyan -NoNewLine ; Write-Host "             :   tools for web pentesting       " -NoNewLine ; Write-Host "|" -f Cyan
        } elif ($1 = "hardening") {
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "1" -f Red -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "complete" -f Red -NoNewLine ; Write-Host "         :   complete configuration        " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "2" -f Cyan -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "Firewall" -f Cyan -NoNewLine ; Write-Host "         :   firewall                      " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "3" -f Green -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "Sysctl (OS)" -f Green -NoNewLine ; Write-Host "      :   sysctl hardening              " -NoNewLine ; Write-Host "|" -f Cyan
                Write-Host "| " -f Cyan -NoNewLine ; Write-Host "[" -NoNewLine ; Write-Host "4" -f DarkYellow -NoNewLine ; Write-Host "] " -NoNewLine ; Write-Host "SSH" -f DarkYellow -NoNewLine ; Write-Host "              :   SSH hardening                 " -NoNewLine ; Write-Host "|" -f Cyan
        }
        Write-Host "|                                                        |" -f Cyan
        Write-Host "----------------------------------------------------------`n" -f Cyan
}

function Initials {
        echo "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀"
        echo "💀                                                     💀"
        echo "💀                       Yggdrasil                     💀"
        Write-Host "💀                     " -NoNewLine ; Write-Host "Version " -f DarkYellow -NoNewLine ; Write-Host "0.8" -f Blue -NoNewLine ; Write-Host "                     💀"
        echo "💀           Rainer Christian Bjoern Herold            💀"
        echo "💀                                                     💀"
        echo "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀`n"
}

function Downloader {
        New-Item "C:/Wordlists" -ItemType Directory
        New-Item "C:/Pentest_Tools" -ItemType Directory

        Set-Location -Path "C:/Pentest_Tools"
        foreach($line in Get-Content "") {
                if ($line -match "") {
                        git clone $line
                        Invoke-WebRequest "" -OutFile ""
                }
        }
}

# Main
Initials
