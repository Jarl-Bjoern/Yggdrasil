#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Libraries
from os import listdir, remove
from os.path import join
from sys import argv

# Arrays
Array_Filter = ['.sh','.deb','.tar.gz','.bz2','.zip','.rar']

# Main
if __name__ == '__main__':
  for File in listdir(str(argv[1])):
     for Filter in Array_Filter:
          try:
              if (File.endswith(Filter)): remove(join(argv[1], File))
          except FileNotFoundError: pass
