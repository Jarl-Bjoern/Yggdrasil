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

# Author
__author__ = "Rainer C. B. Herold"
__copyright__ = "Copyright 2022, Rainer C. B. Herold"
__credits__ = "Rainer C. B. Herold"
__license__ = "MIT license"
__version__ = "0.8"
__maintainer__ = "Rainer C. B. Herold"
__status__ = "Production"

# Libraries
try:
    from argparse import ArgumentParser, FileType, RawTextHelpFormatter, SUPPRESS
    from os import makedirs, name as osname, system, walk
    from os.path import dirname, join, realpath
    from subprocess import DEVNULL, getoutput, run
except ModuleNotFoundError as e: input(f"The module was not found\n\n{e}\n\nPlease confirm with the button 'Return'"), exit()

# Functions
def Check_dosunix():
    if ('Installed: (none)' in getoutput(['sudo apt-cache policy dos2unix']) or 'Installiert: (nein)' in getoutput(['sudo apt-cache policy dos2unix'])):
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
    parser = ArgumentParser(add_help=False, formatter_class=RawTextHelpFormatter)
    optional = parser.add_argument_group('optional arguments')

    if (osname == 'nt'):
        print ("UNDER CONSTRUCTION")
    else:
        optional.add_argument('-aL','--accept-licenses', type=bool, nargs='?', const=True, help='This parameter is required to accept licenses.\n\nLicenses:\n  - Veracrypt\n\n-------------------------------------------------------------------------------------')
        optional.add_argument('-aW','--add-workspace', type=str, default="/opt/workspace", help='This parameter specifies your default workspace location.\n\nDefault: /opt/workspace\n\n-------------------------------------------------------------------------------------')
        optional.add_argument('-hN','--host-name', type=str, help='This parameter specifies the hostname of the kali machine.\n\nDefault: pentest-kali\n\n-------------------------------------------------------------------------------------')
        optional.add_argument('-p','--path', type=str, help='This parameter specifies the target path of your custom tools.\n\n-------------------------------------------------------------------------------------')
        optional.add_argument('-s','--skip', type=bool, nargs='?', const=True, help='This parameter skips the hardening part.\n\nHardening:\n  - Firewall\n  - Operating System\n  - SSH\n\n-------------------------------------------------------------------------------------')
        optional.add_argument('-h','--help', action='help', default=SUPPRESS, help='Show this help message and exit.\n\n-------------------------------------------------------------------------------------')
        args = parser.parse_args()

        Check_dosunix(), Check_Permissions(File_Path)
        Parameters = ""
        for Arg_Name, Arg_Value in vars(args).items():
            if ((Arg_Name != "path" and Arg_Value != None) and (Arg_Name != "host_name" and Arg_Value != None)):
                if (Arg_Name == "accept_licenses"): Parameters += "-aL "
                elif (Arg_Name == "skip"): Parameters += "-s "
                elif (Arg_Name == "add_workspace" and Arg_Value != None): makedirs(args.add_workspace)
            elif ((Arg_Name == "path" and Arg_Value != None) or (Arg_Name == "host_name" and Arg_Value != None)): Parameters += f"{Arg_Value} "
        system(f'sudo bash {Start_Script} {Parameters}')
