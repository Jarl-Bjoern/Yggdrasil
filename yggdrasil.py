#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Vers 0.1  03.05.2022
# Vers 0.2  03.06.2022
# Vers 0.3  24.09.2022
# Vers 0.4  30.09.2022
# Vers 0.5  01.10.2022
# Vers 0.5c 01.10.2022
# Vers 0.5d 04.10.2022
# Vers 0.6  07.10.2022
# Vers 0.6b 08.10.2022
# Vers 0.6c 18.10.2022
# Vers 0.6d 22.10.2022
# Vers 0.7  24.10.2022
# Vers 0.7b 25.10.2022
# Vers 0.7c 27.10.2022
# Vers 0.7d 29.10.2022
# Vers 0.7e 01.11.2022
# Vers 0.7f 02.11.2022
# Vers 0.7g 21.11.2022
# Vers 0.8  12.12.2022
# Vers 0.8a 14.12.2022
# Vers 0.8b 15.12.2022
# Vers 0.9  11.03.2023
# Vers 0.9b 08.09.2023

# Author
__author__     = "Rainer C. B. Herold"
__copyright__  = "Copyright 2022-2024, Rainer C. B. Herold"
__credits__    = "Rainer C. B. Herold"
__license__    = "MIT license"
__version__    = "0.9c"
__maintainer__ = "Rainer C. B. Herold"
__status__     = "Production"

# Libraries
from Resources.Python.Standard_Operations.Libraries import *
from Resources.Python.Standard_Operations.Standard  import Standard
from Resources.Python.Standard_Operations.Colors    import Colors

# Functions
def main():
    File_Path    = dirname(realpath(__file__))
    Start_Script = join(File_Path, "Resources/Workfiles/configurator.sh")

    from Resources.Python.Standard_Operations.ArgParser import Argument_Parser
    args = Argument_Parser()
    del Argument_Parser

    Standard.Carriage_Remove(File_Path), Standard.Check_Permissions(File_Path)
    Parameters = ""
    for Arg_Name, Arg_Value in vars(args).items():
        if ((Arg_Name != "custom_path" and Arg_Value != None) and (Arg_Name != "host_name" and Arg_Value != None)):
            if (Arg_Name == "accept_licenses"):           Parameters += "-aL "
            elif (Arg_Name == "skip_hardening"):          Parameters += "-sH "
            elif (Arg_Name == "skip_config"):             Parameters += "-sC "
            elif (Arg_Name == "skip_basic_installation"): Parameters += "-sbI "
            elif (Arg_Name == "skip_installation"):       Parameters += "-sI "
            elif (Arg_Name == "custom_days"):             Parameters += f"{Arg_Value}.-cD "
            elif (Arg_Name == "skip_urls"):               Parameters += f"-sU "
            elif (Arg_Name == "verbose"):                 Parameters += "-v "
            elif (Arg_Name == "add_workspace" and Arg_Value != None):
                try: makedirs(args.add_workspace)
                except FileExistsError: pass
                Parameters += f"{args.add_workspace}.-aW "
            elif (Arg_Name == "tool_path" and Arg_Value != None):
                try: makedirs(args.tool_path)
                except FileExistsError: pass
                Parameters += f"{args.tool_path}.-tP "
        elif (Arg_Name == "custom_path" and Arg_Value != None): Parameters += f"{Arg_Value}.-p "
        elif (Arg_Name == "host_name" and Arg_Value != None):   Parameters += f"{Arg_Value}.-hN "
    Standard.Initials(), system(f'sudo bash {Start_Script} {Parameters}')

# Main
if __name__ == '__main__':
    try:                      main()
    except KeyboardInterrupt: exit()
