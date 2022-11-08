#!/bin/bash
# Rainer Christian Bjoern Herold

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
