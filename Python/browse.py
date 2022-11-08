#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Vers 0.1 08.11.2022

# Libraries
from sys import argv
from time import sleep
import webbrowser

# Main
if __name__ == '__main__':
  with open(argv[1], 'r') as f:
    for URL in f.read().splitlines():
      webbrowser.open(URL)
      sleep(0.45)
