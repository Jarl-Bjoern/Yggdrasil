#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from Resources.Python.Standard_Operations.Libraries import ArgumentParser, FileType, osname, RawTextHelpFormatter, SUPPRESS
from Resources.Python.Standard_Operations.Colors    import Colors
from os.path                                        import dirname, realpath

def Argument_Parser():
  Program_Description = """-------------------------------------------------------------------------------------
|  Created by Rainer Christian Bjoern Herold                                        |
|  Copyright 2022-2024. All rights reserved.                                        |
|                                                                                   |
|  Please do not use the program for illegal activities.                            |
|                                                                                   |
|  If you got any problems don't hesitate to contact me so I can try to fix them.   |
-------------------------------------------------------------------------------------
"""

  parser   = ArgumentParser(add_help=False, formatter_class=RawTextHelpFormatter, description=Colors.ORANGE+Program_Description+Colors.RESET, usage=SUPPRESS)
  optional = parser.add_argument_group(Colors.ORANGE+'optional arguments'+Colors.RESET)

  if (osname == 'nt'):
      print ("UNDER CONSTRUCTION")
  else:
      optional.add_argument('-aL','--accept-licenses', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter is required to accept licenses the popups from firefox\nduring the installation of extensions.'+Colors.RESET+'\n\nExtensions:\n  - Firefox\n\nLicenses:\n  - Veracrypt\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-aW','--add-workspace', type=str, default="/opt/workspace", help=Colors.GREEN+'This parameter specifies your default workspace location.\n\n'+Colors.RESET+'Default: /opt/workspace\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-cD','--custom-days', type=int, default=90, help=Colors.GREEN+'This parameter specifies the max days for the shredding script.'+Colors.RESET+'\n\nDefault:\n  - 90 Days\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-cP','--custom-path', type=str, help=Colors.GREEN+'This parameter specifies the target path of your custom scripts or tools.\n\n'+Colors.RESET+"Example:\n  - python3 yggdrasil.py -cP /opt/yggdrasil/Custom\n\n"+Colors.GREEN+"It's also possible to select a single file.\n\n"+Colors.RESET+"Example:\n  - python3 yggdrasil.py -cP /opt/yggdrasil/Custom/old-kali-wallpapers.sh\n\n"+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-hN','--host-name', type=str, help=Colors.GREEN+'This parameter specifies the hostname of the kali machine.\n\n'+Colors.RESET+'Default:\n  - pentest-kali\n  - forensic-kali\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-rCf','--read-config-file', type=bool, nargs='?', const=True, default=False, help=Colors.GREEN+'UNDER CONSTRUCTION.\n\n'+Colors.RESET+f"Default: {dirname(realpath(__file__)).replace('Resources/Python/Standard_Operations', 'Config/Automation/Install.cfg')}\n\n"+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-sC','--skip-config', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the configs part.'+Colors.RESET+'\n\nBest practice settings:\n  - Automated Updates (APT|Cargo|Docker|Git Packages|Pip|Rust)\n  - Custom Configs (alias|bashrc|zshrc)\n  - screenrc\n  - vim\n  - repo-change (rolling-release to last-snapshot)\n  - automated shredding task\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-sH','--skip-hardening', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the hardening part.'+Colors.RESET+'\n\nHardening:\n  - Firewall\n  - Operating System\n  - SSH\n  - Apache\n  - nginx\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-sbI','--skip-basic-installation', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the basic tools installation part.\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-sI','--skip-installation', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the installation part.\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-sU','--skip-urls', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter skips the url opening part after the installation process.\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-tP','--tool-path', type=str, help=Colors.GREEN+'This parameter specifies your default tools location.\n\n'+Colors.RESET+'Default:\n  - /opt/pentest_tools\n  - /opt/forensic_tools\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-v','--verbose', type=bool, nargs='?', const=True, help=Colors.GREEN+'This parameter shows all interaction messages during the apt\npackage manager installation process.\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)
      optional.add_argument('-h','--help', action='help', default=SUPPRESS, help=Colors.GREEN+'Show this help message and exit.\n\n'+Colors.BLUE+'-------------------------------------------------------------------------------------'+Colors.RESET)

  return parser.parse_args()
