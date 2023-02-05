#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Function
def Write_Log(Path_Log, Text):
    with open(Path_Log, 'a') as f:
        f.write(f'{Text}\n')
