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
from Python.Resources.Libraries import *
from Python.Resources.Standard import Standard
from Python.Resources.Colors import Colors

# Functions
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

def main():
    File_Path = dirname(realpath(__file__))
    Start_Script = join(File_Path, "configurator.sh")

    from Python.Resources.ArgParser import Argument_Parser
    args = Argument_Parser()
    del Argument_Parser

    Check_dosunix(), Check_Permissions(File_Path)
    Parameters = ""
    for Arg_Name, Arg_Value in vars(args).items():
        if ((Arg_Name != "path" and Arg_Value != None) and (Arg_Name != "host_name" and Arg_Value != None)):
            if (Arg_Name == "accept_licenses"): Parameters += "-aL "
            elif (Arg_Name == "skip_hardening"): Parameters += "-sH "
            elif (Arg_Name == "skip_config"): Parameters += "-sC "
            elif (Arg_Name == "add_workspace" and Arg_Value != None):
                try: makedirs(args.add_workspace)
                except FileExistsError: pass

                Shredder = f"""0 4     * * *  root for data in $(find "{args.add_workspace}" -maxdepth 1 ! -path "{args.add_workspace}"); do if [[ $(expr $(expr "$(date +%s)" - "$(date -d "$(ls -l --time-style=long-iso $data | awk """+"""'{print $6}') +%s)")" / 86400) -gt 90 ]]; then find """+f"""{args.add_workspace}"""+""" -type f -exec shred --remove=wipesync {} + -exec sleep 1.15 +; rm -rf """+f"""{args.add_workspace}"""+"""; fi; done"""
                with open('/etc/crontab', 'r') as f: Temp_Array = f.read().splitlines()
                with open('/etc/crontab', 'a') as f:
                    if (Shredder not in Temp_Array): f.write(f'{Shredder}\n')
        elif ((Arg_Name == "path" and Arg_Value != None) or (Arg_Name == "host_name" and Arg_Value != None)): Parameters += f"{Arg_Value} "
    Standard.Initials(), system(f'sudo bash {Start_Script} {Parameters}')
# Main
if __name__ == '__main__':
    try: main()
    except KeyboardInterrupt: exit()
