#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 29.10.2022

# Libraries
from pyautogui import hotkey, press, write as autowrite
from sys import argv
from time import sleep

# Arrays

# Variables

# Functions
def Veracrypt_Install():
  press("1"), sleep(2)
  press("return"), sleep(2)
  press("return"), sleep(2)
  for i in range(0,8):
    hotkey("shift", "v")
    sleep(0.5)
  autowrite("yes"), sleep(0.5)
  press("return"), sleep(2)
  press("return")

# Main
if __name__ == '__main__':
  if (argv[1] == "Veracrypt"): Veracrypt_Install()
