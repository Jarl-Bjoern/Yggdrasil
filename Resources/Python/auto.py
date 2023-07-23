#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 29.10.2022

# Libraries
try:
    from os                         import kill, listdir, system
    from os.path                    import dirname, join, realpath
    from psutil                     import process_iter
    from pyautogui                  import click as mouse_click, hold, hotkey, keyDown, locateOnScreen, press, size as screen_resolution, write as autowrite
    from signal                     import SIGKILL
    from Standard_Operations.Colors import Colors
    from Standard_Operations.Logger import Write_Log
    from sys                        import argv
    from time                       import sleep
    from threading                  import Thread
except ModuleNotFoundError as e: input(f"The module was not found\n\n{e}\n\nPlease confirm with the button 'Return'"), exit()

# Functions
def Process_ID(Process_Name):
    for P in process_iter():
        if (Process_Name in P.name()):
            return P.pid

def Press_Hotkey(key_One, key_Two, seconds): hotkey(key_One, key_Two), sleep(seconds)

def Press_Key(key, seconds):                 press(key), sleep(seconds)

def Firefox_Addons(Path, License_Parameter, Button_Path = dirname(realpath(__file__)).replace('Python','Auto/Linux/Firefox/Firefox_ADD.jpg')):
    Press_Hotkey('win','right', 2), Press_Key('win', 2), autowrite('firefox'), sleep(2), Press_Key('return', 5), Press_Hotkey('win','left', 2)
    X, Y = screen_resolution().width*0.08, screen_resolution().height*0.38
    try:
        for Extension_File in listdir(Path):
            if (Extension_File.endswith('.xpi')):
                Press_Hotkey('ctrl', 'l', 2)
                autowrite('file:'), Press_Hotkey('shift','7', 0.15)
                for _ in join(Path, Extension_File).split('/'):
                    Press_Hotkey('shift','7', 0.5), autowrite(_)
                Press_Key('return', 2.5)
                if (License_Parameter == "False"):
                    input(Colors.RED+'-----------------------------------------------------------------'+Colors.ORANGE+'\n\nThe script was stopped because the parameter "'+Colors.BLUE+'-aL '+Colors.RED+'|'+Colors.BLUE+' --accept-licenses'+Colors.ORANGE+'" is set to False by default for legal reasons.\n\nPlease confirm the operation with the "'+Colors.BLUE+'Return'+Colors.ORANGE+'" button to continue the program.\n\n'+Colors.RESET)
                    sleep(2), mouse_click(int(X), int(Y))
                else:
                    r, Counter = None, 0
                    while (r == None):
                        if (Counter <= 10): r = locateOnScreen(Button_Path, grayscale=False, confidence=0.85)
                        else:               r = locateOnScreen(Button_Path, grayscale=True, confidence=0.85)

                        if (Counter == 20):
                            print (Colors.RED+"It was not possible to find the Button 'Add'!"+Colors.RESET)
                            Write_Log(dirname(realpath(__file__)).replace('Resources/Python','yggdrasil.log'), Colors.CYAN+"-------------------------------------------------------------------------------\n\n"+Colors.RED+"It was not possible to find the Button 'Add'!"+Colors.RESET)
                            break
                        Counter += 1
                        sleep(0.75)
                    else:
                        mouse_click(r), sleep(1), Write_Log(dirname(realpath(__file__)).replace('Resources/Python','yggdrasil.log'), Colors.CYAN+"-------------------------------------------------------------------------------\n\n"+Colors.RESET+"The Extension "+Colors.ORANGE+f"{Extension_File}"+Colors.RESET+" was successfully installed.")
    except KeyboardInterrupt: print("The program will be closed.")
    finally: kill(Process_ID("firefox"), SIGKILL), sleep(2), hotkey('ctrl','win','up'), sleep(1), hotkey('ctrl','win','up')

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

    Write_Log(dirname(realpath(__file__)).replace('Resource/Python','yggdrasil.log'), Colors.ORANGE+f"Veracrypt was successfully installed."+Colors.RESET)

# Main
if __name__ == '__main__':
    if (argv[1] == "Veracrypt"): Veracrypt_Install(argv[2])
    elif (argv[1] == "Pycharm"): Pycharm_Install(argv[2])
    elif (argv[1] == "SoapUI"):  SoapUI_Install(argv[2])
    elif (argv[1] == "Firefox"): Firefox_Addons(argv[2], argv[3])
