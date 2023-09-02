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
    if (isfile(argv[1])):
        file = argv[1]
        if (file.endswith('.deb')):
                    system(f'sudo dpkg -i {file}')
        elif (file.endswith('.sh') or
              file.endswith('.bash')):
                    system(f'sudo bash {file}')
    elif (isdir(argv[1])):
        for root, _, files in walk(str(argv[1]), topdown=False):
            for file in files:
                if (file.endswith('.deb')):
                            system(f'sudo dpkg -i {join(root, file)}')
                elif (file.endswith('.sh') or
                      file.endswith('.bash')):
                            system(f'sudo bash {join(root, file)}')
