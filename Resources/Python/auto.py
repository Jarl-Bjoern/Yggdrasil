#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 29.10.2022

# Libraries
try:
    from os import kill, listdir, system
    from os.path import join
    from psutil import process_iter
    from pyautogui import hold, hotkey, keyDown, press, write as autowrite
    from signal import SIGKILL
    from Standard_Operations.Colors import Colors
    from sys import argv
    from time import sleep
    from threading import Thread
except ModuleNotFoundError as e: input(f"The module was not found\n\n{e}\n\nPlease confirm with the button 'Return'"), exit()

# Functions
def Process_ID(Process_Name):
    for P in process_iter():
        if (Process_Name in P.name()):
            return P.pid

def Press_Hotkey(key_One, key_Two, seconds): hotkey(key_One, key_Two), sleep(seconds)

def Press_Key(key, seconds): press(key), sleep(seconds)

def Firefox_Addons(Path, License_Parameter):
    Press_Hotkey('win','right', 2), Press_Key('win', 2), autowrite('firefox'), sleep(2), Press_Key('return', 5), Press_Hotkey('win','left', 2)
    for Extension_File in listdir(Path):
        if (Extension_File.endswith('.xpi')):
            Press_Hotkey('ctrl', 'l', 2)
            autowrite('file:'), Press_Hotkey('shift','7', 0.15)
            for _ in join(Path, Extension_File).split('/'):
                Press_Hotkey('shift','7', 0.5), autowrite(_)
            Press_Key('return', 2.5)
            if (License_Parameter == "False"):
                input(Colors.ORANGE+'\n\nThe script was stopped because the parameter "-aL | --accept-licenses" is set to False by default for legal reasons. Please confirm the operation with the "Return" button to continue the program.'+Colors.RESET)
                sleep(2), Press_Hotkey('STRG','F4',2)
            else: pass
    kill(Process_ID("Firefox"), SIGKILL)

def SoapUI_Install(Path):
    def Auto_Install():
        pass

def Pycharm_Install(Path):
    def Auto_Install():
        pass

def Veracrypt_Install(Path):
    def Installer(Path): system(f'sudo bash {Path}')

    def Auto_Install():
        Press_Key('1', 2), Press_Key('return', 2), Press_Key('return', 2)
        for i in range(0,20): Press_Hotkey('ctrl', 'v', 1)
        for i in range(0,30): Press_Key('backspace', 0.5)
        autowrite("yes"), sleep(1)
        Press_Key('return', 2), press("return")

    t1 = Thread(target=Installer, args=[Path], daemon=True).start()
    sleep(1.25)
    t2 = Thread(target=Auto_Install).start()

# Main
if __name__ == '__main__':
    if (argv[1] == "Veracrypt"): Veracrypt_Install(argv[2])
    elif (argv[1] == "Pycharm"): Pycharm_Install(argv[2])
    elif (argv[1] == "SoapUI"): SoapUI_Install(argv[2])
    elif (argv[1] == "Firefox"): Firefox_Addons(argv[2], argv[3])
