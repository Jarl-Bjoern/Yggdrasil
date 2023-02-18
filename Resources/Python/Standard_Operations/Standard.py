#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from Resources.Python.Standard_Operations.Libraries import DEVNULL, getoutput, join, osname, run, sleep, stdout, system, walk
from Resources.Python.Standard_Operations.Colors import Colors

# Classes
class Standard:
    def Stdout_Output(Text_Array):
        for char in Text_Array:
            stdout.write(char)
            stdout.flush()
            sleep(0.008)

    def Initials():
        if (osname == 'nt'): system('cls')
        else: system('clear')
        Header = """💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀\t\t\t\t\t\t\t\t💀
💀\t\t           """+Colors.UNDERLINE+"Yggdrasil"+Colors.RESET+"""\t\t\t\t💀
💀\t\t\t  """+Colors.ORANGE+"Version "+Colors.CYAN+"0.9"+Colors.RESET+"""\t\t\t\t💀
💀\t\tRainer Christian Bjoern Herold\t\t\t💀
💀\t\t\t\t\t\t\t\t💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀\n\n
"""
        Standard.Stdout_Output(Header)

    def Carriage_Remove(File_Path):
        for root, _, files in walk(File_Path, topdown=False):
            for file in files:
                if (not file.endswith('.ps1') or not file.endswith('.py')):
                    with open(join(root, file), 'r', encoding='utf-8') as f:
                        Temp_Text = f.read().replace('\r\n', '\n')
                        with open(join(root, file), 'w') as f:
                            f.write(Temp_Text)

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
