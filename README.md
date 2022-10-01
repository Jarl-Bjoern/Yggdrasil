# General Description

With this repository certain processes are automated, you have the choice between "full_install", which is aimed at a Kali installation with GUI and "minimal_install", which is aimed at the CLI variant.

You have the possibility to customize the config files according to your needs.

# How to download and install the tool
## Download and start the tool
```bash
git clone https://github.com/Jarl-Bjoern/Kali_Configurator/
cd Kali_Configurator
chmod +x *.sh ; dos2unix *.sh Config/*
sudo bash install.sh
```

## Choose one of the three installation types
```bash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|                    Kali Configurator                   |
|                       Version 0.5                      |
|             Rainer Christian Bjoern Herold             |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


          Please choose between a installation
----------------------------------------------------------
|                                                        |
|            full    : full installation (GUI)           |
|            minimal : minimal installation (CLI)        |
|            special : special installation              |
|                                                        |
----------------------------------------------------------

Your Choice: full
```

# Remark
It should be said that the scripts are still under development, but already allow an easier start to perform as a penetration tester, certain pre-settings.
