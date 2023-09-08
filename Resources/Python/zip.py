#!/usr/bin/env python3
#-*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 08.10.2022
# Version 0.2 22.10.2022
# Version 0.3 24.10.2022
# Version 0.4 06.02.2023

# Libraries
from os                         import makedirs, remove
from os.path                    import dirname, realpath
from re                         import finditer
from shutil                     import ReadError, unpack_archive
from Standard_Operations.Colors import Colors
from Standard_Operations.Logger import Write_Log
from sys                        import argv
from tarfile                    import open as tfopen

# Main
if __name__ == '__main__':
    if (len(argv) > 1):
        if ("/" in argv[1]):
            for Slash in finditer("/", argv[1]): Position = Slash.span()[1]
            File = argv[1][Position:]
        else:
            if ('\n' in argv[1] or '\r' in argv[1]): File = argv[1][:-1]
            else:                                    File = argv[1]
        try:
            print (argv[2])
            unpack_archive(f'{argv[2]}/{File}', f'{argv[2]}/')
            Write_Log(dirname(realpath(__file__)).replace('Resources/Python','yggdrasil.log'), Colors.CYAN+"-------------------------------------------------------------------------------\n\n"+Colors.RESET+"The File "+Colors.ORANGE+f"{File}"+Colors.RESET+" was successfully unzipped.")
        except ReadError:
            try:
                with tfopen(f'{argv[2]}/{File}') as f:
                    f.extractall(f'{argv[2]}/')
                Write_Log(dirname(realpath(__file__)).replace('Resources/Python','yggdrasil.log'), Colors.CYAN+"-------------------------------------------------------------------------------\n\n"+Colors.RESET+"The File "+Colors.ORANGE+f"{File}"+Colors.RESET+" was successfully unzipped.")
            except FileNotFoundError: pass
        except FileNotFoundError: pass
        remove (f'{argv[2]}/{File}')
