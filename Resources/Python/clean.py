#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from os                         import listdir, remove
from os.path                    import dirname, join, realpath
from Standard_Operations.Colors import Colors
from Standard_Operations.Logger import Write_Log
from sys                        import argv

# Arrays
Array_Filter = ['.sh','.deb','.tar.gz','.bz2','.zip','.rar','.xpi','.msi']

# Main
if __name__ == '__main__':
    try:
        for File in listdir(str(argv[1])):
            for Filter in Array_Filter:
                try:
                    if (File.endswith(Filter) or Filter in File):
                        remove(join(argv[1], File))
                        Write_Log(dirname(realpath(__file__)).replace('Resources/Python','yggdrasil.log'), Colors.CYAN+"-------------------------------------------------------------------------------\n\n"+Colors.RESET+"The File "+Colors.ORANGE+f"{File}"+Colors.RESET+" was successfully removed.")
                except FileNotFoundError: pass
    except FileNotFoundError: pass
