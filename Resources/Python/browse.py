#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Vers 0.1 08.11.2022

# Libraries
from contextlib import redirect_stdout
from sys        import argv
from time       import sleep
from webbrowser import open as webbrowser_open

# Main
if __name__ == '__main__':
  with open(argv[1], 'r') as f:
      for URL in f.read().splitlines():
          try:
              with redirect_stdout(None):
                  webbrowser_open(URL)
          except: pass
          sleep(0.65)
