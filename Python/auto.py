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
def Press_Key(key, seconds): press(key), sleep(seconds)

def Veracrypt_Install(Path):
  def Installer(Path): system(f'sudo bash {Path}')

  def Auto_Install():
      Press_Key('1', 2), Press_Key('return', 2), Press_Key('return', 2)
      for i in range(0,20):
          hotkey('ctrl', 'v')
          sleep(1)
      for i in range(0,30):
          Press_Key('backspace', 1)
      autowrite("yes"), sleep(1)
      Press_Key('return', 2), press("return")

  t1 = Thread(target=Installer, args=[Path], daemon=True).start()
  sleep(1.25)
  t2 = Thread(target=Auto_Install).start()

# Main
if __name__ == '__main__':
  if (argv[1] == "Veracrypt"): Veracrypt_Install(argv[2])
