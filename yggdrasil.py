#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Vers 0.1 03.05.2022
# Vers 0.2 03.06.2022
# Vers 0.3 24.09.2022
# Vers 0.4 30.09.2022
# Vers 0.5 01.10.2022
# Vers 0.5c 01.10.2022
# Vers 0.5d 04.10.2022
# Vers 0.6 07.10.2022
# Vers 0.6b 08.10.2022
# Vers 0.6c 18.10.2022
# Vers 0.6d 22.10.2022
# Vers 0.7 24.10.2022
# Vers 0.7b 25.10.2022
# Vers 0.7c 27.10.2022
# Vers 0.7d 29.10.2022
# Vers 0.7e 01.11.2022
# Vers 0.7f 02.11.2022
# Vers 0.7g 21.11.2022
# Vers 0.8 12.12.2022
# Vers 0.8a 14.12.2022
# Vers 0.8b 15.12.2022

# Author
__author__ = "Rainer C. B. Herold"
__copyright__ = "Copyright 2022-2023, Rainer C. B. Herold"
__credits__ = "Rainer C. B. Herold"
__license__ = "MIT license"
__version__ = "0.9"
__maintainer__ = "Rainer C. B. Herold"
__status__ = "Production"

# Libraries
try:
    from argparse import ArgumentParser, FileType, RawTextHelpFormatter, SUPPRESS
    from os import makedirs, name as osname, system, walk
    from os.path import dirname, join, realpath
    from subprocess import DEVNULL, getoutput, run
    from sys import stdout
    from time import sleep
except ModuleNotFoundError as e: input(f"The module was not found\n\n{e}\n\nPlease confirm with the button 'Return'"), exit()

# Variables
Program_Description = """-------------------------------------------------------------------------------------
|  Created by Rainer Christian Bjoern Herold                                        |
|  Copyright 2022-2023. All rights reserved.                                        |
|                                                                                   |
|  Please do not use the program for illegal activities.                            |
|                                                                                   |
|  If you got any problems don't hesitate to contact me so I can try to fix them.   |
-------------------------------------------------------------------------------------
"""

# Classes
class Colors:
    CYAN = '\033[36m'
    GREEN = '\033[32m'
    ORANGE = '\033[33m'
    BLUE = '\033[34m'
    RED = '\033[31m'
    UNDERLINE = '\033[4m'
    RESET = '\033[0m'

# Functions
def Stdout_Output(Text_Array):
    for char in Text_Array:
        stdout.write(char)
        stdout.flush()
        sleep(0.008)

def Initials():
    if (osname == 'nt'): system('cls')
    else: system('clear')
    Header = """????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
????\t\t\t\t\t\t\t\t????
????\t\t           """+Colors.UNDERLINE+"Yggdrasil"+Colors.RESET+"""\t\t\t\t????
????\t\t\t  """+Colors.ORANGE+"Version "+Colors.CYAN+"0.8"+Colors.RESET+"""\t\t\t\t????
????\t\tRainer Christian Bjoern Herold\t\t\t????
????\t\t\t\t\t\t\t\t????
????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????\n\n
"""
    Stdout_Output(Header)

def Check_dosunix():
    if ('Installed: (none)' in getoutput(['sudo apt-cache policy dos2unix']) or 'Installiert: (keine)' in getoutput(['sudo apt-cache policy dos2unix'])):
        print ("Installing dos2unix"), run(['sudo','apt','install','-y','dos2unix'], stdin=DEVNULL, stdout=DEVNULL, stderr=DEVNULL), print ("The installing process was successful.")

def Check_Permissions(File_Path):
    def Permission_Change(File): run(['sudo','chmod','+x',File], stdin=DEVNULL, stdout=DEVNULL, stderr=DEVNULL)
    def Converter(File): run(['sudo','dos2unix',File], stdin=DEVNULL, stdout=DEVNULL, stderr=DEVNULL)

    for root, _, files in walk(File_Path, topdown=False):
        for file in files:
            if (file.endswith('.py')): Permission_Change(join(root, file))
            elif (file.endswith('.sh')): Permission_Change(join(root, file))
            Converter(join(root, file))

# Main
if __name__ == '__main__':
    File_Path = dirname(realpath(__file__))
    Start_Script = join(File_Path, "configurator.sh")
    parser = ArgumentParser(add_help=False, formatter_class=RawTextHelpFormatter, description=Colors.ORANGE+Program_Description+Colors.RESET)
    optional = parser.add_argument_group(Colors.ORANGE+'optional arguments'+Colors.RESET)

    if (osname == 'nt'):
        print ("UNDER CONSTRUCTION")
    else:
        optional.add_argument('-aL','--accept-licenses', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter is required to accept licenses.'+Colors.RESET+'\n\nLicenses:\n  - Veracrypt\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
        optional.add_argument('-aW','--add-workspace', type=str, default="/opt/workspace", help=Colors.GREEN+'This parameter specifies your default workspace location.\n\n'+Colors.RESET+'Default: /opt/workspace\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
        optional.add_argument('-hN','--host-name', type=str, help=Colors.GREEN+'This parameter specifies the hostname of the kali machine.\n\n'+Colors.RESET+'Default: pentest-kali\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
        optional.add_argument('-p','--path', type=str, help=Colors.GREEN+'This parameter specifies the target path of your custom tools.\n\n'+Colors.RESET+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
        optional.add_argument('-s','--skip', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the hardening part.'+Colors.RESET+'\n\nHardening:\n  - Firewall\n  - Operating System\n  - SSH\n  - Apache\n  - nginx\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
        optional.add_argument('-h','--help', action='help', default=SUPPRESS, help=Colors.GREEN+'Show this help message and exit.\n\n'+Colors.RESET+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
        args = parser.parse_args()

        Check_dosunix(), Check_Permissions(File_Path)
        Parameters = ""
        for Arg_Name, Arg_Value in vars(args).items():
            if ((Arg_Name != "path" and Arg_Value != None) and (Arg_Name != "host_name" and Arg_Value != None)):
                if (Arg_Name == "accept_licenses"): Parameters += "-aL "
                elif (Arg_Name == "skip"): Parameters += "-s "
                elif (Arg_Name == "add_workspace" and Arg_Value != None):
                    try: makedirs(args.add_workspace)
                    except FileExistsError: pass
            elif ((Arg_Name == "path" and Arg_Value != None) or (Arg_Name == "host_name" and Arg_Value != None)): Parameters += f"{Arg_Value} "
        Initials(), system(f'sudo bash {Start_Script} {Parameters}')
