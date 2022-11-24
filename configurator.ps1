# Rainer Christian Bjoern Herold
# UNDER CONSTRUCTION

# Variables

# Arrays
$Filter_Download = @('C:/Pentest_Tools')


# Functions
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
        New-Item "" -ItemType Directory

        foreach($line in Get-Content "") {
                if ($line -match "") {
                        Invoke-WebRequest "" -OutFile ""
                }
        }
}

# Main
Initials
