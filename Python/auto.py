#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 29.10.2022

# Libraries
from os import system
from pyautogui import hotkey, press, write as autowrite
from sys import argv
from time import sleep
from threading import Thread

# Arrays

# Variables

# Functions
def Veracrypt_Install(Path):
  def Installer(Path):
      system(f'sudo bash {Path}')
  
  def Auto_Install():
      press("1"), sleep(2)
      press("return"), sleep(2)
      press("return"), sleep(2)
      for i in range(0,8):
        hotkey("shift", "v")
        sleep(0.5)
      autowrite("yes"), sleep(0.5)
      press("return"), sleep(2)
      press("return")
      
  t1 = Thread(target=Installer, args=[Path], daemon=True).start()
  sleep(1.25)
  t2 = Thread(target=Auto_Install, daemon=True)

# Main
if __name__ == '__main__':
  if (argv[1] == "Veracrypt"): Veracrypt_Install(argv[2])
