#!/bin/bash
# Rainer Christian Bjoern Herold
# Vers 0.1 03.05.2022
# Vers 0.2 03.06.2022
# Vers 0.3 24.09.2022

sed -i "s#deb http://http.kali.org/kali kali-rolling main contrib non-free#deb https://http.kali.org/kali kali-last-snapshot main contrib non-free#g" /etc/apt/sources.list
apt update -y ; apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all
apt install -y sublist3r gobuster testssl.sh docker.io
pip3 install bloodhound
cat <<EOF >> /etc/crontab
0 6     * * *  root apt update -y ; DEBIAN_FRONTEND=noninteractive apt full-upgrade -y ; apt autoremove -y --purge ; apt clean all ; unset DEBIAN_FRONTEND
EOF
cat <<EOF > /home/`ls /home | grep -v "lost+found"`/.screenrc
hardstatus on
hardstatus alwayslastline
hardstatus string "%{.bW}%-w%{.rW}%n %t%{-}%+w %=%{..G} %Y-%m-%d %c "
EOF
declare -a Array_GIT=("https://github.com/MobSF/Mobile-Security-Framework-MobSF"
"https://github.com/FortyNorthSecurity/EyeWitness"
"https://github.com/Hackplayers/evil-winrm"
"https://github.com/honze-net/nmap-bootstrap-xsl"
"https://github.com/TryCatchHCF/PacketWhisper"
"https://github.com/stufus/egresscheck-framework"
"https://github.com/tennc/webshell"
"https://github.com/cddmp/enum4linux-ng"
"https://github.com/rebootuser/LinEnum"
"https://github.com/sleventyeleven/linuxprivchecker"
"https://github.com/mzet-/linux-exploit-suggester"
"https://github.com/bitsadmin/wesng"
"https://github.com/PowershellMafia/PowerSploit"
"https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite"
"https://github.com/armosec/kubescape"
"https://github.com/carlospolop/PEASS-ng"
"https://github.com/SecureAuthCorp/impacket"
"https://github.com/0xRadi/OWASP-Web-Checklist"
"https://github.com/nabla-c0d3/sslyze"
"https://github.com/bettercap/bettercap"
"https://github.com/fozavci/viproy-voipkit"
"https://github.com/rbagrov/SIPTools"
"https://github.com/lgandx/Responder"
"https://github.com/PowerShellMafia/PowerSploit"
"https://github.com/the-useless-one/pywerview"
"https://github.com/mozilla/ssh_scan"
"https://github.com/AonCyberLabs/Windows-Exploit-Suggester")
cd /opt ; mkdir kerbrute ; cd kerbrute
wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 -O kerbrute
chmod +x kerbrute ; cd /opt
for i in ${Array_GIT[@]}; do
	git clone $i
done
cd PEASS-ng/metasploit
cp ./peass.rb /usr/share/metasploit-framework/modules/post/multi/gather/
bash /opt/EyeWitness/Python/setup/setup.sh
cd /opt/ssh_scan ; gem install bundler ; bundle install
mkdir -p /opt/wordlists ; cd /opt/wordlists
declare -a Array_Wordlists=("https://github.com/fuzzdb-project/fuzzdb"
"https://github.com/swisskyrepo/PayloadsAllTheThings"
"https://github.com/danielmiessler/SecLists"
"https://github.com/xmendez/wfuzz"
"https://github.com/xajkep/wordlists")
for i in ${Array_Wordlists[@]}; do
	git clone $i
done
for i in ${Array_SED[@]}; do
	sed -i 's/#$i/$i/g' /etc/sysctl.conf
done
systemctl enable --now postgresql
msfdb init
sed -i "s/prompt_symbol=㉿/prompt_symbol=💀/g" ~/.zshrc
docker pull mikesplain/openvas
docker pull tenableofficial/nessus
docker run -d -p 8834:8834 --rm --name nessus tenableofficial/nessus
docker run -d -p 443:443 --rm --name openvas mikesplain/openvas
############################### UPDATE NVT ####################################
#docker exec -it openvas bash
#greenbone-nvt-sync
#openvasmd --rebuild --progress
#greenbone-certdata-sync
#greenbone-scapdata-sync
#openvasmd --update --verbose --progress
#
#/etc/init.d/openvas-manager restart
#/etc/init.d/openvas-scanner restart
#exit
###############################################################################
mkdir /home/$USER/.updater ; chmod 700 /home/$USER/.updater
cat <<EOF > /home/$USER/.updater/image_updater.py
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer C. Bjoern Herold
# 04.06.2022

# Libraries
from subprocess import getoutput
from os import system

# Arrays
Array_Container = getoutput('docker images').splitlines()

# Main
if __name__ == '__main__':
        for i in range(1, len(Array_Container)):
                system(f'docker pull {Array_Container[i].split(" ")[0]};')
EOF
chmod 600 /home/$USER/.updater
cat <<EOF >> /etc/crontab
0 6     * * *  root /usr/bin/env python3 /home/$USER/.updater/image_updater.py
EOF
$SHELL