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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|                    Kali Configurator                   |
|                       Version 0.7                      |
|             Rainer Christian Bjoern Herold             |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


          Please choose between one category
----------------------------------------------------------
|                                                        |
|     complete    :   installation of both tools         |
|     forensic    :   installation of forensic tools     |
|     pentest     :   installation of pentest tools      |
|                                                        |
----------------------------------------------------------

Your Choice: pentest
```

## Choose one of the two installation types
```bash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|                    Kali Configurator                   |
|                       Version 0.7                      |
|             Rainer Christian Bjoern Herold             |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


          Please choose between one installation
----------------------------------------------------------
|                                                        |
|            full    : full installation (GUI)           |
|            minimal : minimal installation (CLI)        |
|                                                        |
----------------------------------------------------------

Your Choice: full
```

## Using the automated variant
```bash
# Automated Variant without SSH and Firewall configuration
cat <<EOF | sudo bash /opt/Kali_Configurator/install.sh -s
pentest
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
