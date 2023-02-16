#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold
# Version 0.1 07.10.2022
# Version 0.2 21.11.2022

# Libraries
from os.path import join
from sys import argv

# Standard_Functions
def read_file(path_to_file):
        with open(path_to_file, 'r') as f:
                return f.read().splitlines()

def write_file(path_to_file, config_var):
        Array_Temp = read_file(path_to_file)
        with open(path_to_file, 'a') as f:
                for _ in config_var.splitlines():
                        if (_ not in Array_Temp): f.write(f'{_}\n')

def Service_Writer(path_to_file, input_text):
        with open(path_to_file, 'w') as f:
                f.write(input_text)

# Work_Functions
def Alias_Configuration(path_to_file, opt_path):
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
"""+rf"""alias git-tools-update='BACK="$(pwd)" ; for i in $(cat {opt_path}/update.info); do echo -e "\033[1;33mUpdate:\033[0m" "$i" ; cd "$i" ; git pull ; echo -e "\033[0;36m------------------------------------------------\033[0m"; done; cd "$BACK"'
alias cargo-tools-update='for i in $(cat {opt_path}/update_cargo.info); do echo -e "\033[1;33mUpdate:\033[0m" $i ; cargo install --force $i ; echo -e "\033[0;36m------------------------------------------------\033[0m"; done'"""
        Config_Alias_BSH = r"""alias la='ls -lha --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias ffs='sudo $(history -p !!)'
alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'
function b64() { echo $1 | base64 -d | xxd; }
alias nmap='nmap --exclude $(ip a | grep inet | cut -d " " -f6 | cut -d "/" -f1 | tr "\n" "," | rev | cut -c2- | rev)'
alias microcode-update='sudo sed -i "s#kali-last-snapshot#kali-rolling#g" /etc/apt/sources.list ; sudo apt clean all ; sudo apt update -y ; sudo apt install -y intel-microcode amd64-microcode ; sudo apt clean all ; sudo sed -i "s#kali-rolling#kali-last-snapshot#g" /etc/apt/sources.list'
"""+rf"""alias git-tools-update='BACK="$(pwd)" ; for i in $(cat {opt_path}/update.info); do echo -e "\033[1;33mUpdate:\033[0m" $i ; cd "$i" ; git pull ; echo -e "\033[0;36m------------------------------------------------\033[0m"; done; cd "$BACK"'
alias cargo-tools-update='for i in $(cat {opt_path}/update_cargo.info); do echo -e "\033[1;33mUpdate:\033[0m" $i ; cargo install --force $i ; echo -e "\033[0;36m------------------------------------------------\033[0m"; done'"""

        if ('.zshrc' in path_to_file): write_file(path_to_file, Config_Alias_ZSH)
        else: write_file(path_to_file, Config_Alias_BSH)

def Crontab_Configuration(path_to_file, opt_path):
        Config_Crontab = f"""0 6     * * *  root apt update -y ; DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all ; unset DEBIAN_FRONTEND
0 6     * * *  root for Cont_IMG in $(docker images | cut -d " " -f1 | grep -v "REPOSITORY"); do docker pull $Cont_IMG; done
0 6     * * *  root for Image in $(docker images | grep "<none>" | awk '"""+"""{print $3}');"""+f""" do docker image rm $Image; done
0 5     * * *  root pip3 install --upgrade pip setuptools python-debian
0 5     * * *  root for CARGO_TOOL in "$(cat {opt_path}/update_cargo.info)"; do cargo install --force "$CARGO_TOOL"; done
0 3     * * *  root for GIT_TOOL in "$(cat {opt_path}/update.info)"; do cd "$GIT_TOOL"; git pull; done"""
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
'# -A INPUT -i eth2 -s 123.123.123.123/32 -p tcp --dport 4444 -j ACCEPT -m comment --comment "Reverse Shell 4444/tcp"']
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

def Shredder_Configuration(path_to_file, path_workspace, shredding_days):
        Config_Shredder = f"""0 4     * * *  root for data in $(find "{path_workspace}" -maxdepth 1 ! -path "{path_workspace}"); do if [[ $(expr $(expr "$(date +%s)" - "$(date -d "$(ls -l --time-style=long-iso $data | awk """+"""'{print $6}') +%s)") / 86400) -gt """+f"""{shredding_days}"""+""" ]]; then find """+f"""{path_workspace}"""+""" -type f -exec shred --remove=wipesync {} + -exec sleep 1.15 +; rm -rf """+f"""{path_workspace}"""+"""; fi; done"""
        write_file(path_to_file, Config_Shredder)

def Systemd_Shredder_Configuration(path_to_file, path_workspace, shredding_days):
        Crontab_Commands = {
        'Yggdrasil_Workspace_Cleaner':
                {
                        'Time': '4',
                        'Command': """for data in $(find "{path_workspace}" -maxdepth 1 ! -path "{path_workspace}"); do if [[ $(expr $(expr "$(date +%s)" - "$(date -d "$(ls -l --time-style=long-iso $data | awk """+"""'{print $6}') +%s)") / 86400) -gt """+f"""{shredding_days}"""+""" ]]; then find """+f"""{path_workspace}"""+""" -type f -exec shred --remove=wipesync {} + -exec sleep 1.15 +; rm -rf """+f"""{path_workspace}"""+"""; fi; done"""
                }

        Temp_File_Name = join(path_to_file, 'Yggdrasil_Workspace_Cleaner')
        Base_Unit = f"""# Rainer Christian Bjoern Herold

[Unit]
Description=This script is to install updates

[Service]
Type=oneshot
ExecStart={Crontab_Commands['Yggdrasil_Workspace_Cleaner']['Command']}"""

                Base_Timer = f"""# Rainer Christian Bjoern Herold

[Unit]
Description=This script is to install updates
Requires=Yggdrasil_Workspace_Cleaner.service

[Timer]
Unit=Yggdrasil_Workspace_Cleaner.service
OnCalendar=*-*-* 00/{Crontab_Commands['Yggdrasil_Workspace_Cleaner']['Time']}:00:00

[Install]
WantedBy=multi-user.target"""

        # File_Creation
        Service_Writer(f'{Temp_File_Name}.service', Base_Unit)
        Service_Writer(f'{Temp_File_Name}.timer', Base_Timer)

def Systemd_Service_And_Timer_Configuration(path_to_file, opt_path):
        Crontab_Commands = {
        'Yggdrasil_System_Updates':
                {
                        'Time': '6',
                        'Command': 'apt update -y ; DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all ; unset DEBIAN_FRONTEND'
                },
        'Yggdrasil_Container_Updates':
                {
                        'Time': '6',
                        'Command': 'for Cont_IMG in $(docker images | cut -d " " -f1 | grep -v "REPOSITORY"); do docker pull $Cont_IMG; done'
                },
        'Yggdrasil_Container_Cleaner':
                {
                        'Time': '6',
                        'Command': 'for Image in $(docker images | grep "<none>" | awk "{print $3}"); do docker image rm $Image; done'
                },
        'Yggdrasil_PIP_Updater':
                {
                        'Time': '5',
                        'Command': 'pip3 install --upgrade pip setuptools python-debian'
                },
        'Yggdrasil_Cargo_Updater':
                {
                        'Time': '5',
                        'Command': f'root for CARGO_TOOL in "$(cat {opt_path}/update_cargo.info)"; do cargo install --force "$CARGO_TOOL"; done'
                },
        'Yggdrasil_GIT_Updater':
                {
                        'Time': '3',
                        'Command': f'root for GIT_TOOL in "$(cat {opt_path}/update.info)"; do cd "$GIT_TOOL"; git pull; done'
                }
        }

        for Unit in Crontab_Commands:
                Temp_File_Name = join(path_to_file, Unit)
                Base_Unit = f"""# Rainer Christian Bjoern Herold

[Unit]
Description=This script is to install updates

[Service]
Type=oneshot
ExecStart={Crontab_Commands[Unit]['Command']}"""

                Base_Timer = f"""# Rainer Christian Bjoern Herold

[Unit]
Description=This script is to install updates
Requires={Unit}.service

[Timer]
Unit={Unit}.service
OnCalendar=*-*-* 00/{Crontab_Commands[Unit]['Time']}:00:00

[Install]
WantedBy=multi-user.target"""

                # File_Creation
                Service_Writer(f'{Temp_File_Name}.service', Base_Unit)
                Service_Writer(f'{Temp_File_Name}.timer', Base_Timer)

# Main
if __name__ == '__main__':
        try:
                if ("crontab" in argv[1]):
                        if ("shred" in argv[3]): Shredder_Configuration(argv[1], argv[2], argv[4])
                        elif ("normal" in argv[3]): Crontab_Configuration(argv[1], argv[2])
                elif ("rules.v4" in argv[1]): Firewall_Configuration(argv[1])
                elif ("rules.v6" in argv[1]): Firewall_Configuration(argv[1])
                elif (".zshrc" in argv[1] or ".bashrc" in argv[1]): Alias_Configuration(argv[1], argv[2])
                elif ("/systemd/system" in argv[1]):
                        if ("shred" in argv[3]): Systemd_Shredder_Configuration(argv[1], argv[2], argv[4])
                        elif ("normal" in argv[3]): Systemd_Service_And_Timer_Configuration(argv[1], argv[2])
        except FileNotFoundError: pass
