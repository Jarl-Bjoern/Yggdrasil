#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 07.10.2022
# Version 0.2 21.11.2022

# Libraries
from sys import argv

# Functions
def read_file(path_to_file):
        with open(path_to_file, 'r') as f:
                return f.read().splitlines()

def write_file(path_to_file, config_var):
        Array_Temp = read_file(path_to_file)
        with open(path_to_file, 'a') as f:
                for _ in config_var.splitlines():
                        if (_ not in Array_Temp): f.write(f'{_}\n')

def Crontab_Configuration(path_to_file):
        Config_Crontab = """0 6     * * *  root apt update -y ; DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all ; unset DEBIAN_FRONTEND
0 6     * * *  root for Cont_IMG in $(docker images | cut -d " " -f1 | grep -v "REPOSITORY"); do docker pull $Cont_IMG; done
0 5     * * *  root pip3 install --upgrade pip setuptools python-debian
0 3     * * *  root for GIT_TOOL in $(cat /opt/pentest_tools/update.info); do cd $GIT_TOOL; git pull; done"""
        write_file(path_to_file, Config_Crontab)

def Firewall_Configuration(path_to_file):
        Array_v4 = ["# Allow established, related and localhost traffic",
"-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT",
"-A INPUT -s 127.0.0.0/8 -j ACCEPT",
"# Allow incoming PING",
'-A INPUT -p icmp --icmp-type 8 -s 0/0 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT -m comment --comment "ACCEPT icmp echo (ping) requests"',
"# Allow incoming SSH connections with protection",
'-A INPUT -p tcp --dport 22 -j ACCEPT -m comment --comment "ACCEPT ssh connections to port 22/tcp"',
"-A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 600 --hitcount 10 -j DROP",
"# Other stuff like reverse-shell access et alii",
'# -A INPUT -i eth2 -s 123.123.123.123 -p tcp --dport 4444 -j ACCEPT -m comment --comment "Reverse Shell 4444/tcp"']
        Array_v6 = ["# Accept all established and related connections",
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

        Array_Temp, Array_File = [], read_file(path_to_file)
        for Text in Array_File:
                if ("Commit" not in Text): Array_Temp.append(Text)

        with open(path_to_file, 'a') as f:
                if ("v4" in path_to_file):
                        for _ in Array_v4:
                                if (_ not in Array_Temp): f.write(f'{_}\n')
                elif ("v6" in path_to_file):
                        for _ in Array_v6:
                                if (_ not in Array_Temp): f.write(f'{_}\n')

def Alias_Configuration(path_to_file):
        Config_Alias_ZSH = r"""alias la='ls -lha --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias ffs='sudo $(history -p !!)'
alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'
setopt hist_ignore_all_dups
function b64() { echo $1 | base64 -d | xxd; }
alias nmap='nmap --exclude $(ip a | grep inet | cut -d " " -f6 | cut -d "/" -f1 | tr "\n" "," | rev | cut -c2- | rev)'
alias microcode-update='sudo sed -i "s#kali-last-snapshot#kali-rolling#g" /etc/apt/sources.list ; sudo apt clean all ; sudo apt update -y ; sudo apt install -y intel-microcode amd64-microcode ; sudo apt clean all ; sudo sed -i "s#kali-rolling#kali-last-snapshot#g" /etc/apt/sources.list'
alias git-tools-update='for i in $(cat /opt/pentest_tools/update.info); do echo "Update:" $i ; cd $i ; git pull ; echo "------------------------------------------------"; done'"""
        Config_Alias_BSH = r"""alias la='ls -lha --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias ffs='sudo $(history -p !!)'
alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'
function b64() { echo $1 | base64 -d | xxd; }
alias nmap='nmap --exclude $(ip a | grep inet | cut -d " " -f6 | cut -d "/" -f1 | tr "\n" "," | rev | cut -c2- | rev)'
alias microcode-update='sudo sed -i "s#kali-last-snapshot#kali-rolling#g" /etc/apt/sources.list ; sudo apt clean all ; sudo apt update -y ; sudo apt install -y intel-microcode amd64-microcode ; sudo apt clean all ; sudo sed -i "s#kali-rolling#kali-last-snapshot#g" /etc/apt/sources.list'
alias git-tools-update='for i in $(cat /opt/pentest_tools/update.info); do echo "Update:" $i ; cd $i ; git pull ; echo "------------------------------------------------"; done'"""

        if ('.zshrc' in path_to_file): write_file(path_to_file, Config_Alias_ZSH)
        else: write_file(path_to_file, Config_Alias_BSH)

# Main
if __name__ == '__main__':
        try:
                if ("crontab" in argv[1]): Crontab_Configuration(argv[1])
                elif ("rules.v4" in argv[1]): Firewall_Configuration(argv[1])
                elif ("rules.v6" in argv[1]): Firewall_Configuration(argv[1])
                elif (".zshrc" in argv[1] or ".bashrc" in argv[1]): Alias_Configuration(argv[1])
        except FileNotFoundError:
                pass
