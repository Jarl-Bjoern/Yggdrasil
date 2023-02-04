#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 29.10.2022

# Libraries
from os import system
from pyautogui import hold, hotkey, keyDown, press, write as autowrite
from sys import argv
from time import sleep
from threading import Thread

# Functions
def Press_Hotkey(key_One, key_Two, seconds): hotkey(key_One, key_Two), sleep(seconds)

def Press_Key(key, seconds): press(key), sleep(seconds)

def Firefox_Addons(Path):
  Press_Key('win', 2)
  autowrite('firefox'), sleep(2)
  Press_Key('return', 5)
  Press_Hotkey('ctrl', 'k', 2), Press_Key('backspace', 1)
  autowrite('file:')
  Press_Hotkey('shift','7', 0.15)
  for _ in Path.split('/'):
      Press_Hotkey('shift','7', 0.5)
      autowrite(_)
  Press_Key('return', 2.5)

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
  elif (argv[1] == "Firefox"): Firefox_Addons(argv[2])
