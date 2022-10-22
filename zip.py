#!/usr/bin/env python3
#-*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 08.10.2022
# Version 0.2 22.10.2022

# Libraries
from os import remove
from re import finditer
from shutil import unpack_archive
from sys import argv

# Main
if __name__ == '__main__':
    if ("/" in argv[1]):
        for Slash in finditer("/", argv[1]): Position = Slash.span()[1]
        File = argv[1][Position:]
    else:
        if ('\n' in argv[1]): File = argv[1][:-1]
        else: File = argv[1]
    unpack_archive(f'/opt/pentest_tools/{File}', f'/opt/pentest_tools/')
    remove (f'/opt/pentest_tools/{File}')
