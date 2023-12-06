#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 27.10.2022
# Version 0.2 02.09.2023

# Libraries
from os                         import system, walk
from os.path                    import dirname, exists, isdir, isfile, join, realpath
from Standard_Operations.Colors import Colors
from Standard_Operations.Logger import Write_Log
from sys                        import argv

# Main
if __name__ == '__main__':
    if ('\r' in argv[1]): Temp = argv[1].split('\r')[0]
    else:                 Temp = argv[1]

    if (isfile(Temp) or '.deb' in Temp[-6:]):
        file = Temp
        if (file.endswith('.deb') or
            '.deb' in file[-6:]):
                    system(f'sudo dpkg -i {file}')
        elif (file.endswith('.sh')   or
              file.endswith('.bash') or
              '.sh'   in file[-6:]   or
              '.bash' in file[-6:]):
                    system(f'sudo bash {file}')
    elif (isdir(argv[1])):
        for root, _, files in walk(str(Temp), topdown=False):
            for file in files:
                if (file.endswith('.deb')    or '.deb' in file[1][-6:]):
                            system(f'sudo dpkg -i {join(root, file)}')
                elif (file.endswith('.sh')   or
                      file.endswith('.bash') or
                      '.sh'   in file[-6:]   or
                      '.bash' in file[-6:]):
                            system(f'sudo bash {join(root, file)}')
