#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from Resources.Python.Libraries import ArgumentParser, FileType, osname, RawTextHelpFormatter, SUPPRESS
from Resources.Python.Colors import Colors

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
      optional.add_argument('-hN','--host-name', type=str, help=Colors.GREEN+'This parameter specifies the hostname of the kali machine.\n\n'+Colors.RESET+'Default:\n  - pentest-kali\n  - forensic-kali\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-p','--path', type=str, help=Colors.GREEN+'This parameter specifies the target path of your custom tools.\n\n'+Colors.RESET+'Example:\n  - python3 yggdrasil.py -p /opt/yggdrasil/Custom\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-sC','--skip-config', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the configs part.'+Colors.RESET+'\n\nBest practice settings:\n  - Automated Updates (APT|Docker|Git Packages|Pip)\n  - Custom Configs (alias|bashrc|zshrc)\n  - screenrc\n  - vim\n  - repo-change (rolling-release to last-snapshot)\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-sH','--skip-hardening', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the hardening part.'+Colors.RESET+'\n\nHardening:\n  - Firewall\n  - Operating System\n  - SSH\n  - Apache\n  - nginx\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-tP','--tool-path', type=str, help=Colors.GREEN+'This parameter specifies your default tools location.\n\n'+Colors.RESET+'Default:\n  - /opt/pentest_tools\n  - /opt/forensic_tools\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-v','--verbose', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter shows all messages during the apt package manager installation process.\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-h','--help', action='help', default=SUPPRESS, help=Colors.GREEN+'Show this help message and exit.\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)

  return parser.parse_args()
