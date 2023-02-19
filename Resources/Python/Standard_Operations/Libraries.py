#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
try:
    from argparse import ArgumentParser, FileType, RawTextHelpFormatter, SUPPRESS
    from os import makedirs, name as osname, system, walk
    from os.path import dirname, join, realpath
    from subprocess import DEVNULL, run
    from sys import stdout
    from time import sleep
except ModuleNotFoundError as e: input(f"The module was not found\n\n{e}\n\nPlease confirm with the button 'Return'"), exit()
