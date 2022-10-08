#!/usr/bin/env python3
#-*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 08.10.2022

# Libraries
from os import remove
from shutil import unpack_archive
from sys import argv

# Main
if __name__ == '__main__':
        try:
                unpack_archive(f'/opt/{argv[1]}', f'/opt')
                remove (f'/opt/{argv[1]}')
        except: pass
