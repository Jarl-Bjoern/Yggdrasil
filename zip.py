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
    unpack_archive(f'/opt/pentest_tools/{argv[1][:-1]}', f'/optpentest_tools/')
    remove (f'/opt/pentest_tools/{argv[1][:-1]}')
