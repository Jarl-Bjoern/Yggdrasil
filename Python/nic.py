#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from subprocess import getoutput
from Python.Resources.Colors import Colors

NIC = getoutput('ip --brief a | grep "UP" | grep -v "lo|docker|veth"').split(' ')
for IP_Address in range(0, len(NIC)):
        if (IP_Address == len(NIC)-1): print(Colors.CYAN+'-----------------------------------------------------------------')
        if (NIC[IP_Address] != "" and NIC[IP_Address] != "UP"):
                if ("/" in NIC[IP_Address]):
                        if (NIC[IP_Address].count(':') > 1): print (f'  - {NIC[IP_Address].split("/")[0]} '+Colors.CYAN+'(IPv6)')
                        else: print(f'  - {NIC[IP_Address].split("/")[0]} '+Colors.GREEN+'(IPv4)')
                else:
                        print (Colors.ORANGE+f'{NIC[IP_Address]}:')
