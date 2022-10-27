#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 27.10.2022

# Libraries
from os import system, walk
from os.path import exists, join
from sys import argv

# Main
if __name__ == '__main__':
  if (exists(argv[1])):
    for root, _, files in walk(str(argv[1]), topdown=False):
      for file in files:
        if (file.endswith('.deb')): system(f'sudo dpkg -i {join(root, file)}')
        elif (file.endswith('.sh')): system(f'sudo bash {join(root, file)}')
