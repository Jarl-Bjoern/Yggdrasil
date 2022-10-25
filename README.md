# General Description

This repository is used to automate certain processes. 

Since version 0.7 it is now possible to choose between the three categories "Forensic", "Complete" and "Pentest".

Furthermore, you have the choice between "full_install", which is aimed at a Kali installation with GUI and "minimal_install", which is aimed at the CLI variant.

You have the possibility to customize the config files according to your needs.<br />

# How to download and install the tool
## Download and start the tool
```bash
git clone https://github.com/Jarl-Bjoern/Kali_Configurator/
cd Kali_Configurator
chmod +x *.sh *.py ; dos2unix $(find . -type f)
sudo bash install.sh
```
## Choose one of the three category types
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                      💀
💀                       Ragnarök                       💀
💀                     Version 0.7b                     💀
💀           Rainer Christian Bjoern Herold             💀
💀                                                      💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


          Please choose between one category
----------------------------------------------------------
|                                                        |
| [1] complete    :   installation of both toolkits      |
| [2] custom      :   installation of custom tools       |
| [3] forensic    :   installation of forensic tools     |
| [4] pentest     :   installation of pentest tools      |
|                                                        |
----------------------------------------------------------

Your Choice: pentest
```

## Choose between one of the Pentesting categories
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                      💀
💀                       Ragnarök                       💀
💀                     Version 0.7b                     💀
💀           Rainer Christian Bjoern Herold             💀
💀                                                      💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


          Please choose between one category
----------------------------------------------------------
|                                                        |
| [1] infrastructure  :   tools for infra pentesting     |
| [2] iot             :   tools for iot pentesting       |
| [3] mobile          :   tools for mobile pentesting    |
| [4] red_teaming     :   tools for red teaming          |
| [5] web             :   tools for web pentesting       |
|                                                        |
----------------------------------------------------------

Your Choice: infrastructure
```

## Choose one of the two installation types
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                      💀
💀                       Ragnarök                       💀
💀                     Version 0.7b                     💀
💀           Rainer Christian Bjoern Herold             💀
💀                                                      💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


          Please choose between one installation
----------------------------------------------------------
|                                                        |
|  [1]       full    : full installation (GUI)           |
|  [2]       minimal : minimal installation (CLI)        |
|                                                        |
----------------------------------------------------------

Your Choice: full
```

## Using the automated variant
```bash
# Automated Variant without Firewall, Hardening and SSH configuration
cat <<EOF | sudo bash /opt/Kali_Configurator/install.sh -s
pentest
infrastructure
full
EOF
```

# Customize your installation
You can open the configuration file and add your own tools to the list to customize it to your liking (Make sure that the heading must always begin with a #).
```bash
# APT
feroxbuster
YOUR_EXAMPLE

# Git
https://github.com/Jarl-Bjoern/Kali_Configurator/
```

For example, when you arrive at the "Wget" section, you need to see that they follow the structure below.

"URL" "Name" "Method

```bash
# Wget
https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 kerbrute Executeable
https://dl.pstmn.io/download/latest/linux64 Postman Archive
```

# Remark
It should be said that the scripts are still under development, but already allow an easier start to perform as a penetration tester or digital forensics, certain pre-settings.
