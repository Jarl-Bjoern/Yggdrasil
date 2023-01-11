#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from Python.Resources.Libraries import osname, stdout, system
from Python.Resources.Colors import Colors

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
  💀\t\t\t  """+Colors.ORANGE+"Version "+Colors.CYAN+"0.8"+Colors.RESET+"""\t\t\t\t💀
  💀\t\tRainer Christian Bjoern Herold\t\t\t💀
  💀\t\t\t\t\t\t\t\t💀
  💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀\n\n
  """
      Standard.Stdout_Output(Header)
