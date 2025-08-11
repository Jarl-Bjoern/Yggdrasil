#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from os.path                    import join
from Standard_Operations.Colors import Colors
from Standard_Operations.Logger import Write_Log
from sys                        import argv

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
def Alias_Configuration(path_to_file, opt_path, yggdrasil_path):
        Config_Alias_ZSH = r"""alias la='ls -lha --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias ffs='sudo $(history -p !!)'
alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'
setopt hist_ignore_all_dups
function Yggdrasil_File_Reader() { input=$1; while IFS= read -r line; do if [[ $line =~ "##" ]]; then echo -e "\033[0;32m$line\033[0m"; else; echo -e "\033[1;33m$line\033[0m"; fi; done < "$input" }
function b64() { echo $1 | base64 -d | xxd; }
function Yggdrasil_Repo_Switch() { if [[ $(cat /etc/apt/sources.list | head -n2 | grep -v "#" | cut -d ' ' -f3) == "kali-last-snapshot" ]]; then sed -i 's#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware#deb https://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware#g' /etc/apt/sources.list ; echo -e "The repository was successfully changed to \033[0;32mkali-rolling\033[0m"; elif [[ $(cat /etc/apt/sources.list | head -n2 | grep -v "#" | cut -d ' ' -f3) == "kali-rolling" ]]; then sed -i 's#deb https://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware#g' /etc/apt/sources.list ; echo -e "The repository was successfully changed to \033[0;32mkali-last-snapshot\033[0m"; fi }
function yggdrasil-custom { if [[ "$1" ]]; then sudo python3 {yggdrasil_path}/Resources/Python/browse.py "$1"; else sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Custom.txt"; fi }
function yggdrasil-vnc() { if [[ $(netstat -tnap | grep 'x11vnc' | awk '{print $7}' | cut -d '/' -f1 | sort -u) ]]; then for i in $(netstat -tnap | grep 'x11vnc' | awk '{print $7}' | cut -d '/' -f1 | sort -u); do kill $i; done; fi; if [[ $(netstat -tnap | grep -v 'tcp6' | awk '{print $4}' | cut -d ':' -f2 | grep '8081') ]]; then kill $(netstat -tnap | grep -v 'tcp6' | grep '0.0.0.0:8081' | awk '{print $7}' | cut -d '/' -f1); fi; sudo x11vnc -storepasswd ; sudo x11vnc -display :0 -autoport -bg -localhost -rfbauth ~/.vnc/passwd -xkb -ncache -ncache_cr -quiet & ; /usr/share/novnc/utils/novnc_proxy --listen 8081 --vnc localhost:5900 --idle-timeout 900 --ssl-only --key /opt/ssl/pentest-key.pem --cert /opt/ssl/pentest-cert.pem }
"""+"""function Yggdrasil_Old_Tool_Monitor() { for GIT_Old_Tool in """+f"""$(cat {opt_path}/update.info); do if [[ ! $(find {opt_path} -maxdepth 1 -type d | grep "$GIT_Old_Tool") ]] && [[ ! $(find /opt/wordlists -maxdepth 1 -type d | grep "$GIT_Old_Tool") ]]; then sed -i "s#$GIT_Old_Tool##g" {opt_path}/update.info; fi; done; sed -i '/^$/d' {opt_path}/update.info """+"""}
function Yggdrasil_New_Tool_Monitor() {"""+f""" for GIT_Tool in $(find {opt_path} -maxdepth 2 -type d -name ".git" | rev | cut -c6- | rev); do if [[ ! $(cat {opt_path}/update.info | grep "$GIT_Tool") ]]; then echo "$GIT_Tool" >> {opt_path}/update.info; fi; done """+"""}
"""+r"""alias cls='clear'
alias ls='eza -l -F -g -h --icons --group-directories-first'
alias ls_old='/usr/bin/ls'
alias nmap='nmap --exclude $(ip a | grep inet | cut -d " " -f6 | cut -d "/" -f1 | tr "\n" "," | rev | cut -c2- | rev)'
alias sslyze='sslyze --sslv2 --sslv3 --tlsv1 --tlsv1_1 --tlsv1_2 --tlsv1_3 --elliptic_curves --http_headers --certinfo --resum --early_data --openssl_ccs --fallback --heartbleed --robot --compression --reneg --mozilla_config intermediate'
alias kali-repo-switch='Yggdrasil_Repo_Switch'
alias microcode-update='sudo sed -i "s#kali-last-snapshot#kali-rolling#g" /etc/apt/sources.list ; sudo apt clean all ; sudo apt update -y ; sudo apt install -y intel-microcode amd64-microcode ; sudo apt clean all ; sudo sed -i "s#kali-rolling#kali-last-snapshot#g" /etc/apt/sources.list'
"""+rf"""alias git-tools-update='BACK="$(pwd)" ; for i in $(cat {opt_path}/update.info); do echo -e "\033[1;33mUpdate:\033[0m" "$i" ; cd "$i" ; git pull ; echo -e "\033[0;36m------------------------------------------------\033[0m"; sleep 0.75; done; cd "$BACK"'
alias cargo-tools-update='for i in $(cat {opt_path}/update_cargo.info); do echo -e "\033[1;33mUpdate:\033[0m" $i ; cargo install --force $i ; echo -e "\033[0;36m------------------------------------------------\033[0m"; sleep 0.45; done'
alias yggdrasil-info='Yggdrasil_File_Reader "/opt/yggdrasil/Information/info.txt" | less -r'
alias yggdrasil-osint='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/OSINT.txt" &> /dev/null'
alias yggdrasil-forensic='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Forensic.txt" &> /dev/null'
alias yggdrasil-education='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Education.txt" &> /dev/null'
alias yggdrasil-hardening='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Hardening.txt" &> /dev/null'
alias yggdrasil-pentesting='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Infrastructure.txt" &> /dev/null'
alias yggdrasil-web='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Web.txt" &> /dev/null'
alias yggdrasil-rust-update='wget https://sh.rustup.rs -O /tmp/rust_install.sh ; sudo chmod +x /tmp/rust_install.sh ; sudo bash /tmp/rust_install.sh -y ; sudo rm -f /tmp/rust_install.sh'
alias yggdrasil-services='for i in $(find "/usr/lib/systemd/system" -type f -name "Yggdrasil*" | grep "service" | sort -u); do sudo systemctl --no-pager status $(echo "$i" | rev | cut -d "/" -f1 | rev); echo -e "\033[0;36m------------------------------------------------\033[0m\n"; done'
"""
        Config_Alias_BSH = r"""alias la='ls -lha --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias ffs='sudo $(history -p !!)'
alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'
function b64() { echo $1 | base64 -d | xxd; }
alias cls='clear'
alias ls='eza -l -F -g -h --icons --group-directories-first'
alias ls_old='/usr/bin/ls'
alias nmap='nmap --exclude $(ip a | grep inet | cut -d " " -f6 | cut -d "/" -f1 | tr "\n" "," | rev | cut -c2- | rev)'
alias sslyze='sslyze --sslv2 --sslv3 --tlsv1 --tlsv1_1 --tlsv1_2 --tlsv1_3 --elliptic_curves --http_headers --certinfo --resum --early_data --openssl_ccs --fallback --heartbleed --robot --compression --reneg --mozilla_config intermediate'
alias kali-repo-switch='Yggdrasil_Repo_Switch'
alias microcode-update='sudo sed -i "s#kali-last-snapshot#kali-rolling#g" /etc/apt/sources.list ; sudo apt clean all ; sudo apt update -y ; sudo apt install -y intel-microcode amd64-microcode ; sudo apt clean all ; sudo sed -i "s#kali-rolling#kali-last-snapshot#g" /etc/apt/sources.list'
"""+rf"""alias git-tools-update='BACK="$(pwd)" ; for i in $(cat {opt_path}/update.info); do echo -e "\033[1;33mUpdate:\033[0m" $i ; cd "$i" ; git pull ; echo -e "\033[0;36m------------------------------------------------\033[0m"; sleep 0.75; done; cd "$BACK"'
alias cargo-tools-update='for i in $(cat {opt_path}/update_cargo.info); do echo -e "\033[1;33mUpdate:\033[0m" $i ; cargo install --force $i ; echo -e "\033[0;36m------------------------------------------------\033[0m"; sleep 0.45; done'
alias yggdrasil-info='Yggdrasil_File_Reader "/opt/yggdrasil/Information/info.txt" | less -r'
alias yggdrasil-osint='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/OSINT.txt" &> /dev/null'
alias yggdrasil-forensic='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Forensic.txt" &> /dev/null'
alias yggdrasil-education='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Education.txt" &> /dev/null'
alias yggdrasil-hardening='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Hardening.txt" &> /dev/null'
alias yggdrasil-pentesting='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Infrastructure.txt" &> /dev/null'
alias yggdrasil-web='sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Web.txt" &> /dev/null'
alias yggdrasil-rust-update='wget https://sh.rustup.rs -O /tmp/rust_install.sh ; sudo chmod +x /tmp/rust_install.sh ; sudo bash /tmp/rust_install.sh -y ; sudo rm -f /tmp/rust_install.sh'
"""
        Config_Alias_Profile = r'. "$HOME/.cargo/env"'

        if ('.zshrc' in path_to_file): write_file(path_to_file, Config_Alias_ZSH)
        elif ('.profile' in path_to_file): write_file(path_to_file, Config_Alias_Profile)
        else:
                write_file(path_to_file, Config_Alias_BSH)
                with open(path_to_file, 'r') as f:
                        with open(path_to_file, 'a') as fa:
                                Temp_Check = f.read().splitlines()
                                if ("function Yggdrasil_shredder()" not in Temp_Check):
                                        fa.write("""function Yggdrasil_shredder() {\n    for data in $(find "$1" -maxdepth 1 -type d ! -path "$1"); do\n        TEMP_DATE_SHRED="$(/usr/bin/ls -l --time-style=long-iso $1 | grep $(echo $data | rev | cut -d '/' -f1 | rev) | awk '{print $6}')"\n        if [[ "${#TEMP_DATE_SHRED}" -eq 10 ]]; then\n            if [[ $(expr $(expr "$(date +%s)" - $(date -d "$TEMP_DATE_SHRED" +%s)) / 86400) -gt 90 ]]; then\n                find $data -type f -exec shred --remove=wipesync {} -exec sleep 1.15; rm -rf $data\n            fi\n        fi\n    done\n}\n""")
                                if ("function Yggdrasil_File_Reader()" not in Temp_Check):
                                        fa.write("""function Yggdrasil_File_Reader() {\n    input=$1\n    while IFS= read -r line\n    do\n        if [[ $line =~ "##" ]]; then\n            echo -e "\033[0;32m$line\033[0m"\n        else\n            echo -e "\033[1;33m$line\033[0m"\n        fi\n    done < "$input"\n}\n""")
                                if ("function yggdrasil-vnc()" not in Temp_Check):
                                        fa.write("""function yggdrasil-vnc() {\n    if [[ $(netstat -tnap | grep 'x11vnc' | awk '{print $7}' | cut -d '/' -f1 | sort -u) ]]; then\n        for i in $(netstat -tnap | grep 'x11vnc' | awk '{print $7}' | cut -d '/' -f1 | sort -u);\n            do kill $i\n        done\n    fi\n    if [[ $(netstat -tnap | grep -v 'tcp6' | awk '{print $4}' | cut -d ':' -f2 | grep '8081') ]]; then\n        kill $(netstat -tnap | grep -v 'tcp6' | grep '0.0.0.0:8081' | awk '{print $7}' | cut -d '/' -f1)\n    fi\n    sudo x11vnc -storepasswd\n    sudo x11vnc -display :0 -autoport -bg -localhost -rfbauth ~/.vnc/passwd -xkb -ncache -ncache_cr -quiet &\n    /usr/share/novnc/utils/novnc_proxy --listen 8081 --vnc localhost:5900 --idle-timeout 900 --ssl-only --key /opt/ssl/pentest-key.pem --cert /opt/ssl/pentest-cert.pem\n}\n""")
                                if ("function yggdrasil-custom()" not in Temp_Check):
                                        fa.write("""function yggdrasil-custom() {\n    if [[ "$1" ]]; then\n        sudo python3 {yggdrasil_path}/Resources/Python/browse.py "$1" &> /dev/null\n    else\n        sudo python3 {yggdrasil_path}/Resources/Python/browse.py "{yggdrasil_path}/Information/Pages/Custom.txt" &> /dev/null\n    fi\n}\n""")
                                if ("function Yggdrasil_Repo_Switch()" not in Temp_Check):
                                        fa.write("""function Yggdrasil_Repo_Switch() {\n    if [[ $(cat /etc/apt/sources.list | head -n2 | grep -v "#" | cut -d ' ' -f3) == "kali-last-snapshot" ]]; then\n        sed -i 's#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware#deb https://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware#g' /etc/apt/sources.list\n        echo -e "The repository was successfully changed to \033[0;32mkali-rolling\033[0m"\n    elif [[ $(cat /etc/apt/sources.list | head -n2 | grep -v "#" | cut -d ' ' -f3) == "kali-rolling" ]]; then\n        sed -i 's#deb https://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware#g' /etc/apt/sources.list\n        echo -e "The repository was successfully changed to \033[0;32mkali-last-snapshot\033[0m"\n    fi\n}\n""")
                                if ("function Yggdrasil_Old_Tool_Monitor()" not in Temp_Check):
                                        fa.write("""function Yggdrasil_Old_Tool_Monitor() {\n    for GIT_Old_Tool in $(cat {opt_path}/update.info); do\n        if [[ ! $(find {opt_path} /opt/wordlists /opt/hashcat_rules -maxdepth 1 -type d | grep "$GIT_Old_Tool") ]] && [[ ! $(find /opt/wordlists -maxdepth 1 -type d | grep "$GIT_Old_Tool") ]]; then\n            sed -i "s#$GIT_Old_Tool##g" {opt_path}/update.info\n        fi\n    done\n    sed -i '/^$/d' {opt_path}/update.info\n}\n""")
                                if ("function Yggdrasil_New_Tool_Monitor()" not in Temp_Check):
                                        fa.write("""function Yggdrasil_New_Tool_Monitor() {\n    for GIT_Tool in $(find {opt_path} /opt/wordlists /opt/hashcat_rules -maxdepth 2 -type d -name ".git" | rev | cut -c6- | rev)\n    do\n          if [[ ! $(cat {opt_path}/update.info | grep "$GIT_Tool") ]]\n          then\n            echo "$GIT_Tool" >> {opt_path}/update.info\n         fi\n    done\n}\n""")

def Crontab_Configuration(path_to_file, opt_path):
        Crontab_Commands = {
        'Yggdrasil_System_Updates':
                {
                        'Time': '6',
                        'Command': 'apt update -y ; DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all',
                        'Path': '/etc/yggdrasil/Yggdrasil_System_Updates.sh'
                },
        'Yggdrasil_Container_Updates':
                {
                        'Time': '6',
                        'Command': 'for Cont_IMG in $(docker images | cut -d " " -f1 | grep -v "REPOSITORY"); do docker pull $Cont_IMG; sleep 1.15; done',
                        'Path': '/etc/yggdrasil/Yggdrasil_Container_Updates.sh'
                },
        'Yggdrasil_Container_Cleaner':
                {
                        'Time': '6',
                        'Command': """for Image in $(docker images | grep "<none>" | awk '{print $3}'); do docker image rm $Image; done""",
                        'Path': '/etc/yggdrasil/Yggdrasil_Container_Cleaner.sh'
                },
        'Yggdrasil_PIP_Updater':
                {
                        'Time': '5',
                        'Command': 'pip3 install --upgrade pip setuptools python-debian',
                        'Path': '/etc/yggdrasil/Yggdrasil_PIP_Updater.sh'
                },
        'Yggdrasil_Cargo_Updater':
                {
                        'Time': '5',
                        'Command': f'input="{opt_path}/update_cargo.info"; while IFS= read -r CARGO_TOOL; do for i in $(find "/root" "/home" -type f -name "cargo" | grep -v ".rustup"); do "$i" install --force "$CARGO_TOOL" ; sleep 30; done; done < "$input"',

                        'Path': '/etc/yggdrasil/Yggdrasil_Cargo_Updater.sh'
                },
        'Yggdrasil_Rust_Updater':
                {
                        'Time': '5',
                        'Command': f'for i in $(find "/root" "/home" -type f -name "rustup"); do "$i" update; done',
                        'Path': '/etc/yggdrasil/Yggdrasil_Rust_Updater.sh'
                },
        'Yggdrasil_GIT_Updater':
                {
                        'Time': '3',
                        'Command': f'HOME="/root"; input="{opt_path}/update.info"; while IFS= read -r GIT_TOOL; do cd "$GIT_TOOL" && /usr/bin/git pull ; sleep 30; done < "$input"',
                        'Path': '/etc/yggdrasil/Yggdrasil_GIT_Updater.sh'
                },
        'Yggdrasil_GIT_Monitor':
                {
                        'Time': '3',
                        'Command': f'for GIT_Tool in $(find {opt_path} /opt/wordlists /opt/hashcat_rules -maxdepth 2 -type d -name ".git" | rev | cut -c6- | rev); do if [[ ! $(cat {opt_path}/update.info | grep "$GIT_Tool") ]]; then echo "$GIT_Tool" >> {opt_path}/update.info; fi; done',
                        'Path': '/etc/yggdrasil/Yggdrasil_GIT_Monitor.sh'
                },
        'Yggdrasil_GIT_Monitor_Cleaner':
                {
                        'Time': '3',
                        'Command': f"""for GIT_Old_Tool in $(cat {opt_path}/update.info); do if [[ ! $(find {opt_path} /opt/wordlists /opt/hashcat_rules -maxdepth 1 -type d | grep "$GIT_Old_Tool") ]] && [[ ! $(find /opt/wordlists -maxdepth 1 -type d | grep "$GIT_Old_Tool") ]]; then sed -i "s#$GIT_Old_Tool##g" {opt_path}/update.info; fi; done; sed -i '/^$/d' {opt_path}/update.info""",
                        'Path': '/etc/yggdrasil/Yggdrasil_GIT_Monitor_Cleaner.sh'
                }
        }

        for Unit in Crontab_Commands:
                write_file(path_to_file, f"0 */{Crontab_Commands[Unit]['Time']}     * * *  root /bin/bash {Crontab_Commands[Unit]['Path']}")
                Service_Writer(Crontab_Commands[Unit]['Path'], Crontab_Commands[Unit]['Command'])

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
        Config_Shredder = f'0 */4     * * *  root Yggdrasil_shredder "{path_workspace}"'
        write_file(path_to_file, Config_Shredder)

def Systemd_Shredder_Configuration(path_to_file, path_workspace, shredding_days):
        Crontab_Commands = {
        'Yggdrasil_Workspace_Cleaner':
                {
                        'Time': '4',
                        'Command': f"""for data in $(find "{path_workspace}" -maxdepth 1 -type d ! -path "{path_workspace}"); do TEMP_DATE_SHRED="$(/usr/bin/ls -l --time-style=long-iso {path_workspace} | grep $(echo $data | rev | cut -d '/' -f1 | rev) | awk """+"'{print $6}'"+""")"; if [[ "${#TEMP_DATE_SHRED}" -eq 10 ]]; then if [[ $(expr $(expr "$(date +%s)" - $(date -d "$TEMP_DATE_SHRED" +%s)) / 86400) -gt 90 ]]; then find $data -type f -exec shred --remove=wipesync {} -exec sleep 1.15; rm -rf $data; fi; fi; done""",
                        'Path': '/etc/yggdrasil/Yggdrasil_Workspace_Cleaner.sh'
                }
        }

        Temp_File_Name = join(path_to_file, 'Yggdrasil_Workspace_Cleaner')
        Base_Unit = f"""# Rainer Christian Bjoern Herold

[Unit]
Description=This script was created to cleaning up the workspace

[Service]
Type=oneshot
ExecStart=/bin/bash {Crontab_Commands['Yggdrasil_Workspace_Cleaner']['Path']}"""

        Base_Timer = f"""# Rainer Christian Bjoern Herold

[Unit]
Description=This script was created to cleaning up the workspace
Requires=Yggdrasil_Workspace_Cleaner.service

[Timer]
Unit=Yggdrasil_Workspace_Cleaner.service
OnCalendar=*-*-* 00/{Crontab_Commands['Yggdrasil_Workspace_Cleaner']['Time']}:00:00

[Install]
WantedBy=multi-user.target"""

        # File_Creation
        Service_Writer(f'{Temp_File_Name}.service', Base_Unit)
        Service_Writer(f'{Temp_File_Name}.timer', Base_Timer)
        Service_Writer(Crontab_Commands['Yggdrasil_Workspace_Cleaner']['Path'], Crontab_Commands['Yggdrasil_Workspace_Cleaner']['Command'])

def Systemd_Service_And_Timer_Configuration(path_to_file, opt_path):
        Crontab_Commands = {
        'Yggdrasil_System_Updates':
                {
                        'Time': '6',
                        'Command': 'apt update -y ; apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all',
                        'Description_One': 'The script was designed to trigger the systemd unit to install system updates.',
                        'Description_Two': 'This script was formed to install automatically system updates.',
                        'Path': '/etc/yggdrasil/Yggdrasil_System_Updates.sh'
                },
        'Yggdrasil_Container_Updates':
                {
                        'Time': '6',
                        'Command': 'for Cont_IMG in $(docker images | cut -d " " -f1 | grep -v "REPOSITORY"); do docker pull $Cont_IMG; done',
                        'Description_One': 'The script was designed to trigger the systemd unit to install docker image updates.',
                        'Description_Two': 'This script was formed to install automatically docker image updates.',
                        'Path': '/etc/yggdrasil/Yggdrasil_Container_Updates.sh'
                },
        'Yggdrasil_Container_Cleaner':
                {
                        'Time': '6',
                        'Command': """for Image in $(docker images | grep "<none>" | awk '{print $3}'); do docker image rm $Image; done""",
                        'Description_One': 'The script was designed to trigger the systemd unit to remove old container images.',
                        'Description_Two': 'This script was formed to remove automatically old docker images',
                        'Path': '/etc/yggdrasil/Yggdrasil_Container_Cleaner.sh'
                },
        'Yggdrasil_PIP_Updater':
                {
                        'Time': '5',
                        'Command': 'pip3 install --upgrade pip setuptools python-debian',
                        'Description_One': 'The script was designed to trigger the systemd unit to install pip package updates.',
                        'Description_Two': 'This script was formed to install automatically pip package updates.',
                        'Path': '/etc/yggdrasil/Yggdrasil_PIP_Updater.sh'
                },
        'Yggdrasil_Cargo_Updater':
                {
                        'Time': '5',
                        'Command': f'input="{opt_path}/update_cargo.info"; while IFS= read -r CARGO_TOOL; do for i in $(find "/root" "/home" -type f -name "cargo" | grep -v ".rustup"); do "$i" install --force "$CARGO_TOOL" ; done; done < "$input"',
                        'Description_One': 'The script was designed to trigger the systemd unit to install cargo tool updates.',
                        'Description_Two': 'This script was formed to install automatically cargo tool updates.',
                        'Path': '/etc/yggdrasil/Yggdrasil_Cargo_Updater.sh'
                },
        'Yggdrasil_Rust_Updater':
                {
                        'Time': '5',
                        'Command': f'for i in $(find "/root" "/home" -type f -name "rustup"); do "$i" update; done',
                        'Description_One': 'The script was designed to trigger the systemd unit to upgrade rust.',
                        'Description_Two': 'This script was formed to upgrade automatically rust.',
                        'Path': '/etc/yggdrasil/Yggdrasil_Rust_Updater.sh'
                },
        'Yggdrasil_GIT_Updater':
                {
                        'Time': '3',
                        'Command': f'HOME="/root"; input="{opt_path}/update.info"; while IFS= read -r GIT_TOOL; do cd "$GIT_TOOL" && /usr/bin/git pull ; sleep 30; done < "$input"',
                        'Description_One': 'The script was designed to trigger the systemd unit to install git tool updates.',
                        'Description_Two': 'The script was formed to upgrade automatically tools which was installed by git.',
                        'Path': '/etc/yggdrasil/Yggdrasil_GIT_Updater.sh'
                },
        'Yggdrasil_GIT_Monitor':
                {
                        'Time': '3',
                        'Command': f'for GIT_Tool in $(find {opt_path} /opt/wordlists /opt/hashcat_rules -maxdepth 2 -type d -name ".git" | rev | cut -c6- | rev); do if [[ ! $(cat {opt_path}/update.info | grep "$GIT_Tool") ]]; then echo "$GIT_Tool" >> {opt_path}/update.info; fi; done',
                        'Description_One': 'The script was designed to trigger the systemd unit to monitor the tool path to add new tools to the upgrade process.',
                        'Description_Two': 'The script was formed to add new tools to the upgrade process of the git tools updater.',
                        'Path': '/etc/yggdrasil/Yggdrasil_GIT_Monitor.sh'
                },
        'Yggdrasil_GIT_Monitor_Cleaner':
                {
                        'Time': '3',
                        'Command': f"""for GIT_Old_Tool in $(cat {opt_path}/update.info); do if [[ ! $(find {opt_path} /opt/wordlists /opt/hashcat_rules -maxdepth 1 -type d | grep "$GIT_Old_Tool") ]] && [[ ! $(find /opt/wordlists -maxdepth 1 -type d | grep "$GIT_Old_Tool") ]]; then sed -i "s#$GIT_Old_Tool##g" {opt_path}/update.info; fi; done; sed -i '/^$/d' {opt_path}/update.info""",
                        'Description_One': 'The script was designed to trigger the systemd unit to remove tools from the update process of the git tools updater which was removed before.',
                        'Description_Two': 'The script was formed to remove not existing git tools from the update process of the git tools updater.',
                        'Path': '/etc/yggdrasil/Yggdrasil_GIT_Monitor_Cleaner.sh'
                }
        }

        for Unit in Crontab_Commands:
                Temp_File_Name = join(path_to_file, Unit)
                Base_Unit = f"""# Rainer Christian Bjoern Herold

[Unit]
Description={Crontab_Commands[Unit]['Description_One']}

[Service]
Type=oneshot
ExecStart=/bin/bash {Crontab_Commands[Unit]['Path']}"""

                Base_Timer = f"""# Rainer Christian Bjoern Herold

[Unit]
Description={Crontab_Commands[Unit]['Description_Two']}
Requires={Unit}.service

[Timer]
Unit={Unit}.service
OnCalendar=*-*-* 00/{Crontab_Commands[Unit]['Time']}:00:00

[Install]
WantedBy=multi-user.target"""

                # File_Creation
                Service_Writer(f'{Temp_File_Name}.service', Base_Unit)
                Service_Writer(f'{Temp_File_Name}.timer', Base_Timer)
                Service_Writer(Crontab_Commands[Unit]['Path'], Crontab_Commands[Unit]['Command'])

# Main
if __name__ == '__main__':
        try:
                if ("crontab" in argv[1]):
                        if ("shred" in argv[3]):    Shredder_Configuration(argv[1], argv[2], argv[4])
                        elif ("normal" in argv[3]): Crontab_Configuration(argv[1], argv[2])
                elif ("rules.v4" in argv[1]): Firewall_Configuration(argv[1])
                elif ("rules.v6" in argv[1]): Firewall_Configuration(argv[1])
                elif (".zshrc" in argv[1] or ".bashrc" in argv[1] or ".profile" in argv[1]): Alias_Configuration(argv[1], argv[2], argv[3])
                elif ("/systemd/system" in argv[1]):
                        if ("shred" in argv[3]):    Systemd_Shredder_Configuration(argv[1], argv[2], argv[4])
                        elif ("normal" in argv[3]): Systemd_Service_And_Timer_Configuration(argv[1], argv[2])
        except FileNotFoundError: pass


