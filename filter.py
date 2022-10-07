#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 07.10.2022

# Arrays
Array_Path = ["/etc/iptables/rules.v4","/etc/iptables/rules.v6"]
Array_v4 = [":INPUT DROP [0:0]",":FORWARD ACCEPT [0:0]",":OUTPUT ACCEPT [0:0]",
"# Allow established, related and localhost traffic",
"-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT",
"-A INPUT -s 127.0.0.0/8 -j ACCEPT",
"# Allow incoming PING",
'-A INPUT -p icmp --icmp-type 8 -s 0/0 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT -m comment --comment "ACCEPT icmp echo (ping) requests"',
"# Allow incoming SSH connections",
'-A INPUT -p tcp --dport 22 -j ACCEPT -m comment --comment "ACCEPT ssh connections to port 22/tcp"',
"# Other stuff like reverse-shell access et alii",
'# -A INPUT -i eth2 -s 123.123.123.123 -p tcp --dport 4444 -j ACCEPT -m comment --comment "Reverse Shell 4444/tcp"']
Array_v6 = [":INPUT DROP [0:0]",":FORWARD ACCEPT [0:0]",":OUTPUT ACCEPT [0:0]",
"# Accept all established and related connections",
"-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT",
"# Accept all connections originating from Link-Local",
"-A INPUT -s ::1/128 -j ACCEPT",
"-A INPUT -m conntrack --ctstate NEW -s fe80::/10 -j ACCEPT",
"# Permit needed ICMP packet types for IPv6 per RFC 4890.",
"-A INPUT              -p ipv6-icmp --icmpv6-type 1   -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 2   -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 3   -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 4   -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 133 -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 134 -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 135 -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 136 -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 137 -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 141 -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 142 -j ACCEPT",
"-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 130 -j ACCEPT",
"-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 131 -j ACCEPT",
"-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 132 -j ACCEPT",
"-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 143 -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 148 -j ACCEPT",
"-A INPUT              -p ipv6-icmp --icmpv6-type 149 -j ACCEPT",
"-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 151 -j ACCEPT",
"-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 152 -j ACCEPT",
"-A INPUT -s fe80::/10 -p ipv6-icmp --icmpv6-type 153 -j ACCEPT"]

# Functions
def read_file(path_to_file):
        with open(path_to_file, 'r') as f:
                return f.read().splitlines()

# Main
if __name__ == '__main__':
        for Path in Array_Path:
                Array_Temp, Array_File = [], read_file(Path)
                for Text in Array_File:
                        if ("Commit" not in Text): Array_Temp.append(Text)

                with open(Path, 'a') as f:
                        for Text in Array_Temp:
                                if (Path == Array_Path[0]):
                                        if (Text not in Array_File): f.write(f'{Text}\n')
                                else:
                                        if (Text not in Array_File): f.write(f'{Text}\n')