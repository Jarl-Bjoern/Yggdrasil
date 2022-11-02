#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Libraries
from os import remove, walk
from os.path import exists, join
from sys import argv

# Arrays
Array_Filter = ['.sh','.deb','.tar','.bz2','.zip','.rar']

# Main
if __name__ == '__main__':
  for root, _, files in walk(str(argv[1]), topdown=False):
    for file in files:
      for Filter in Array_Filter:
        try:
            if (file.endswith(Filter)): remove(join(argv[1], file))
        except FileNotFoundError: pass
