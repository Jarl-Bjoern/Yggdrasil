#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from Python.Resources.Libraries import ArgumentParser, FileType, osname, RawTextHelpFormatter, SUPPRESS
from Python.Resources.Colors import Colors

def Argument_Parser():
  Program_Description = """-------------------------------------------------------------------------------------
|  Created by Rainer Christian Bjoern Herold                                        |
|  Copyright 2022-2023. All rights reserved.                                        |
|                                                                                   |
|  Please do not use the program for illegal activities.                            |
|                                                                                   |
|  If you got any problems don't hesitate to contact me so I can try to fix them.   |
-------------------------------------------------------------------------------------
"""

  parser = ArgumentParser(add_help=False, formatter_class=RawTextHelpFormatter, description=Colors.ORANGE+Program_Description+Colors.RESET)
  optional = parser.add_argument_group(Colors.ORANGE+'optional arguments'+Colors.RESET)

  if (osname == 'nt'):
      print ("UNDER CONSTRUCTION")
  else:
      optional.add_argument('-aL','--accept-licenses', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter is required to accept licenses.'+Colors.RESET+'\n\nLicenses:\n  - Veracrypt\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-aW','--add-workspace', type=str, default="/opt/workspace", help=Colors.GREEN+'This parameter specifies your default workspace location.\n\n'+Colors.RESET+'Default: /opt/workspace\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-hN','--host-name', type=str, help=Colors.GREEN+'This parameter specifies the hostname of the kali machine.\n\n'+Colors.RESET+'Default: pentest-kali\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-p','--path', type=str, help=Colors.GREEN+'This parameter specifies the target path of your custom tools.\n\n'+Colors.RESET+'Example:\n  - python3 yggdrasil.py -p /opt/yggdrasil/custom\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-s','--skip', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the hardening part.'+Colors.RESET+'\n\nHardening:\n  - Firewall\n  - Operating System\n  - SSH\n  - Apache\n  - nginx\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-h','--help', action='help', default=SUPPRESS, help=Colors.GREEN+'Show this help message and exit.\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)

  return parser.parse_args()
