#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from subprocess import getoutput
from Resources.Colors import Colors

Array_NIC = getoutput('ip --brief a | grep "UP" | grep -v "lo|docker|veth"').splitlines()

for Network_Adapter in range(0, len(Array_NIC)):
        NIC = Array_NIC[Network_Adapter].split()
        if (IP_Address == len(Array_NIC)-1): print(Colors.CYAN+'-----------------------------------------------------------------'+Colors.RESET)
        for IP_Address in range(0, len(NIC)):
                if (NIC[IP_Address] != "" and NIC[IP_Address] != "UP"):
                        if ("/" in NIC[IP_Address]):
                                if (NIC[IP_Address].count(':') > 1): print (f'  - {NIC[IP_Address].split("/")[0]} '+Colors.CYAN+'(IPv6)'+Colors.RESET)
                                else: print(f'  - {NIC[IP_Address].split("/")[0]} '+Colors.GREEN+'(IPv4)'+Colors.RESET)
                        else:
                                print (Colors.ORANGE+f'{NIC[IP_Address]}:'+Colors.RESET)
