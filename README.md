[![Python 3.10](https://img.shields.io/badge/python-3.10-blue.svg)](https://www.python.org/downloads/release/python-3100/)
![visitors](https://visitor-badge.glitch.me/badge?page_id=jarl-bjoern&left_color=grey&right_color=black)

# General Description

This tool is intended to simplify the setup of various tools and configuration of a Kali machine after a fresh installation and save unnecessary time, so that a predefined list can be used in advance or you can also create your own.<br />

# News
With version ***0.7g*** it is now possible to select multiple categories in pentesting for installation.

Since version ***0.7*** it is now possible to choose between the three categories ***Complete***, ***Forensic*** and ***Pentest***.

Furthermore, you have the choice between ***full_install***, which is aimed at a Kali installation with GUI and ***minimal_install***, which is aimed at the CLI variant.<br />

# Table of Contents
- [How to download and install the tool](#download_install)
  - [Make sure that the dos2unix tool is installed](#dos2unix_install)
  - [Download and start the tool](#start_install)
  - [Using the help section to see which parameters do we have](#help_install)
  - [Choose one of the three category types](#category_install)
  - [Choose between one of the Pentesting categories](#pentesting_install)
  - [Choose between multiple Pentesting categories](#pentesting_multiple_install)
  - [Choose one of the two installation types](#type_install)
  - [Choose between multiple hardening options](#hardening_install)
  - [Configurate your SSH IP-Address](#ssh_install)
- [Using the automated variant](#automate_install)
- [Customize your installation](#custom_install)
  - [Method Example](#method_install)
  - [Custom Directory Example](#directory_install)

<a name="download_install"></a>
# How to download and install the tool

<a name="dos2unix_install"></a>
## Make sure that the dos2unix tool is installed
```bash
sudo apt install -y dos2unix
```

<a name="start_install"></a>
## Download and start the tool
```bash
sudo git clone https://github.com/Jarl-Bjoern/Yggdrasil/
cd Yggdrasil
sudo python3 yggdrasil.py
```

<a name="help_install"></a>
## Using the help section to see which parameters do we have
```bash
usage: yggdrasil.py [-aL [ACCEPT_LICENSES]] [-p PATH] [-s [SKIP]] [-h]

optional arguments:
  -aL [ACCEPT_LICENSES], --accept-licenses [ACCEPT_LICENSES]
                        This parameter is required to accept licenses.
                        
                        Licenses:
                          - Veracrypt
                        
                        ---------------------------------------------------------------
  -p PATH, --path PATH  This parameter specifies the target path of your custom tools.
                        
                        ---------------------------------------------------------------
  -s [SKIP], --skip [SKIP]
                        This parameter skips the hardening part.
                        
                        Hardening:
                          - Firewall
                          - Operating System
                          - SSH
                        
                        ---------------------------------------------------------------
  -h, --help            Show this help message and exit.
                        
                        ---------------------------------------------------------------

```

<a name="category_install"></a>
## Choose one of the three category types
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                       Yggdrasil                       💀
💀                     Version 0.7b                      💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


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

<a name="pentesting_install"></a>
## Choose between one of the Pentesting categories
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                       Yggdrasil                       💀
💀                     Version 0.7b                      💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


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

<a name="pentesting_multiple_install"></a>
## Choose between multiple Pentesting categories
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                       Yggdrasil                       💀
💀                     Version 0.7g                      💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


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

Your Choice: 1,5
```

<a name="type_install"></a>
## Choose one of the two installation types
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                       Yggdrasil                       💀
💀                     Version 0.7b                      💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


          Please choose between one installation
----------------------------------------------------------
|                                                        |
|  [1]       full    : full installation (GUI)           |
|  [2]       minimal : minimal installation (CLI)        |
|                                                        |
----------------------------------------------------------

Your Choice: full
```

<a name="hardening_install"></a>
## Choose between multiple hardening options
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                       Yggdrasil                       💀
💀                     Version 0.8                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀

----------------------------------------------------------
|                                                        |
| [1] complete         :   complete configuration        |
| [2] Firewall         :   firewall                      |
| [3] Sysctl (OS)      :   sysctl hardening              |
| [4] SSH              :   SSH hardening                 |
|                                                        |
----------------------------------------------------------

Your Choice: 1
```

<a name="ssh_install"></a>
## Configurate your SSH IP-Address
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                       Yggdrasil                       💀
💀                     Version 0.8                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


           Please select an IP address to be used
                   for SSH configuration
----------------------------------------------------------

     eth0: 
       -  192.168.56.2 (IPv4)
       -  fe80::XXX:XXXX:XXXX:XXXX (IPv6)
----------------------------------------------------------

Your Choice: 192.168.56.2

```

<a name="automated_install"></a>
## Using the automated variant
```bash
# Automated Variant without Firewall, Hardening and SSH configuration with text
cat <<EOF | sudo bash /opt/Yggdrasil/configurator.sh -s
pentest
infrastructure
full
EOF

# Automated Variant without Firewall, Hardening and SSH configuration with numbers
cat <<EOF | sudo bash /opt/Yggdrasil/configurator.sh -s
4
1
1
EOF

# Automated Variant with multiple pentesting categories without Firewall, Hardening and SSH configuration with numbers
cat <<EOF | sudo bash /opt/Yggdrasil/configurator.sh -s
4
1,5
EOF
```

<a name="custom_install"></a>
# Customize your installation
You can open the configuration file and add your own tools to the list to customize it to your liking (Make sure that the heading must always begin with a **#**).

```bash
# APT
feroxbuster
YOUR_EXAMPLE

# Git
https://github.com/Jarl-Bjoern/Yggdrasil/
```

For example, when you arrive at the ***Wget*** section, you need to see that they follow the structure below.
```
URL Name Method
```

## The following methods are available:
 - Archive
 - DPKG
 - Executeable
 - Installer

<a name="method_install"></a>
## Example
```bash
# Wget
https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 kerbrute Executeable
https://dl.pstmn.io/download/latest/linux64 Postman Archive
```

You can also build the file from scratch yourself. To do this, navigate to the directory ***Config/Linux/Custom*** and edit the file ***install.txt***

In addition, it is also possible that you can place your own scripts or packages in the ***Custom*** directory and use them in the installation script.

For this, you must use the parameter ***-p*** in combination with the absolute path, as in the example below

<a name="directory_install"></a>
## Example
```bash
python3 /opt/Yggdrasil/yggdrasil.py -p /mnt/MY_DIRECTORY
```

# Remark
It should be said that the scripts are still under development, but already allow an easier start to perform as a penetration tester or digital forensics, certain pre-settings.
