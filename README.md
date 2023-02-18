<h1 align="center">💀 Yggdrasil 💀</h1>
<p align="center"></p>
<div align="center">
  <a href="https://www.kali.org/">
    <img alt="linux" src="https://img.shields.io/badge/%20-Linux-1f425f.svg?logo=linux&logoColor=cyan" />
  </a>
  <a href="https://www.python.org/downloads/release/python-3100/">
    <img alt="python" src="https://img.shields.io/badge/python-3.10-blue.svg?logo=python&logoColor=cyan" />
  </a>
  <a href="https://visitor-badge.glitch.me/badge?page_id=jarl-bjoern/yggdrasil&left_color=grey&right_color=blue">
    <img alt="visitors" src="https://visitor-badge.glitch.me/badge?page_id=jarl-bjoern/yggdrasil&left_color=grey&right_color=blue" />
  </a>
</div>
<div align="center">
  <a href="https://GitHub.com/jarl-bjoern/yggdrasil/">
    <img alt="repo size" src="https://img.shields.io/github/repo-size/jarl-bjoern/yggdrasil?logo=github&logoColor=cyan" />
  </a>
  <a href="https://GitHub.com/jarl-bjoern/yggdrasil/releases/">
    <img alt="releases" src="https://img.shields.io/github/downloads/jarl-bjoern/yggdrasil/total?color=blue&logo=github&logoColor=cyan" />
  </a>
  <a href="https://github.com/jarl-bjoern">
      <img title="Follower" src="https://img.shields.io/github/followers/jarl-bjoern?color=blue&label=follow&logo=github&logoColor=cyan&style=flat-square">
  </a>
</div>
<div align="center">
  <a href="https://www.python.org/">
    <img alt="python" src="https://img.shields.io/badge/Made%20with-Python-1f425f.svg" />
  </a>
  <a href="https://www.gnu.org/software/bash/">
    <img alt="bash" src="https://img.shields.io/badge/Made%20with-Bash-1f425f.svg" />
  </a>
    <a href="https://learn.microsoft.com/de-de/powershell/">
    <img alt="powershell" src="https://img.shields.io/badge/Made%20with-PowerShell-1f425f.svg" />
  </a>
</div><br/>

This tool is intended to simplify the setup of various tools and configuration of a Kali machine after a fresh installation and save unnecessary time, so that a predefined list can be used in advance or you can also create your own.<br />

The name `Yggdrasil` comes from Norse mythology and is the tree of life or world tree, here the name is quite appropriate for the concept of the program, as it is geared for several pentetration test areas or even for digital forensics.<br />

## ❗ News
<strong>Upcoming changes for version</strong> `0.9`:
  - new cleaning task for old container images inside the updater settings
  - several new aliases have been added to allow reopening of various important web pages, such as for further education, or the information that appears after installation
  - scalable number of days for the shredding task
  - automated rust language updater
  - new parameter was added to skip the automated url opening process after the installation
  - automated URL opener for meaningful pages for example for pentesting
  - automated installer for firefox extensions
  - added new choice to choose between cronjobs or systemd timer for the automated updates
  - new installation categories was added
  - automated and manual updater for the cargo tools
  - new parameter was added to show interaction messages during the apt installation
  - reorganization of the repository
  - new menu for the best practice settings like vim configuration, crontab etc.
  - automated updater for the git tools
  - ability to choose your own installation directory
  - colorized information after the installation
  - manual update alias for the installed git tools and microcode update
  - added automated shredding task after 90 days for data privacy
  - updated README
  - added hardening options for apache and nginx
  - new colors was added
  - the python files have been split up
  - logging bug fixes
  - bug and logical fixes

<div align="center">
➡️ <a href="https://github.com/Jarl-Bjoern/Yggdrasil/blob/main/Information/Changelog/full.md">
  Full Changelog
</a> ⬅️
</div><br />

## 📃 Settings overview
- Ability to configure your own setting
  - Changing the default installation path to your own
  - Custom config based on the provided template
  - Include a custom path of your own scripts or dpkg packages
- Automation download of tools from the following categories
  - APT
  - Cargo
  - Custom Websites (via wget)
  - Docker
  - Gem
  - Go
  - pip
- Best Practice settings
  - Automated Updater via Crontab
    - Cargo Tools
    - Docker Images
    - GIT Tools
    - Important pip packages
    - OS
    - Rust
  - Autmated cleaning tasks
    - shredding task to delete your penetration test results for privacy reasons after 90 days (default) or after a custom number of days
    - cleaning task to remove old container images
  - Changing the default hostname
  - Custom configuration
    - Alias
      - base64 function
      - yggdrasil colorized file reader function
      - callable yggdrasil best practice information after the installation
      - url opener divided by categories (education | forensic | infrastructure | osint)
      - colorized grep
      - human readable df & du commands
      - manual microcode update
      - manual git tools update
      - nmap exclude for local ip addresses
    - BASHRC and ZSHRC
    - Screenrc
    - VIM
  - Repository change from rolling-release (bleeding-edge) to last-snapshot
  - Overview about some useful information after the install
- GUI automation
  - accept licenses
  - install firefox extensions
- Hardening
  - Apache
  - Firewall
  - Kernel
  - nginx
  - SSH

<br />

# 📖 Table of Contents
- [⛓️ Preparations](#preparation_install)
- [⚔ How to download and install the tool](#download_install)
  - [⚔ Download and start the tool](#start_install)
  - [⚔ Using the help section to see which parameters do we have](#help_install)
  - [⚔ Choose one of the six category types](#category_install)
  - [⚔ Choose between the Pentesting categories](#pentesting_install)
  - [⚔ Choose one of the two installation types](#type_install)
  - [⚔ Choose between the hardening options](#hardening_install)
  - [⚔ Configurate your SSH IP-Address](#ssh_install)
  - [⚔ Choose between the provided best practice settings](#best_practice_settings)
  - [⚔ Choose between one of the two task settings](#task_settings)
  - [⚔ Installation Process](#example_install_process)
- [🔧 Using the automated variant](#automated_install)
- [⚙️ Useful provided functions](#useful_functions)
  - [⚙️ Exclude local IP-Addresses within nmap scans](#nmap_exclude)
  - [⚙️ Manual Tools Updater](#manual_tool_updater)
  - [⚙️ Manual URL Opener](#manual_url_opener)
  - [⚙️ Manual Yggdrasil Info show](#manual_info_show)
- [📝 Customize your installation](#custom_install)
  - [📝 Method Example](#method_install)
  - [📝 Build from scratch](#custom_install_II)
  - [📝 Include Customized Scripts](#directory_install)

<br />

<a name="preparation_install"></a>
# ⛓️ Preparations
The tool `dos2unix` is needed to be able to format all the files of the program into the correct unix format. 
```bash
sudo apt install -y dos2unix
```

If you want to use the provided GUI automation, make sure that the `scrot` tool is installed.
```
sudo apt install -y scrot
```

<strong>Notice:</strong> In some cases, you may need to restart the Kali machine once after the preparations.

<br />

<a name="download_install"></a>
# ⚔ How to download and install the tool

<a name="start_install"></a>
## ⚔ Download and start the tool
```bash
sudo git clone https://github.com/Jarl-Bjoern/Yggdrasil/
cd Yggdrasil
sudo python3 yggdrasil.py
```

<a name="help_install"></a>
## ⚔ Using the help section to see which parameters do we have
```python
usage: yggdrasil.py [-aL [ACCEPT_LICENSES]] [-aW ADD_WORKSPACE] [-cP CUSTOM_PATH]
                    [-hN HOST_NAME] [-sC [SKIP_CONFIG]] [-sD SKIP_DAYS]
                    [-sH [SKIP_HARDENING]] [-tP TOOL_PATH] [-v [VERBOSE]] [-h]

optional arguments:
  -aL [ACCEPT_LICENSES], --accept-licenses [ACCEPT_LICENSES]
                        This parameter is required to accept licenses and the popups
                        from firefox during the installation of extensions.

                        Extensions:
                          - Firefox

                        Licenses:
                          - Veracrypt

                        ---------------------------------------------------------------
  -aW ADD_WORKSPACE, --add-workspace ADD_WORKSPACE
                        This parameter specifies your default workspace location.

                        Default: /opt/workspace

                        ---------------------------------------------------------------
  -cP CUSTOM_PATH, --custom-path CUSTOM_PATH
                        This parameter specifies the target path of your custom scripts
                        or tools.

                        Example:
                          - python3 yggdrasil.py -cP /opt/yggdrasil/Custom

                        ---------------------------------------------------------------
  -hN HOST_NAME, --host-name HOST_NAME
                        This parameter specifies the hostname of the kali machine.

                        Default:
                          - pentest-kali
                          - forensic-kali

                        ---------------------------------------------------------------
  -sC [SKIP_CONFIG], --skip-config [SKIP_CONFIG]
                        This parameter skips the configs part.

                        Best practice settings:
                          - Automated Updates (APT|Cargo|Docker|Git Packages|Pip)
                          - Custom Configs (alias|bashrc|zshrc)
                          - screenrc
                          - vim
                          - repo-change (rolling-release to last-snapshot)

                        ---------------------------------------------------------------
  -sD SKIP_DAYS, --skip-days SKIP_DAYS
                        This parameter specifies the max days for the shredding script.

                        Default:
                          - 90 Days

                        ---------------------------------------------------------------
  -sH [SKIP_HARDENING], --skip-hardening [SKIP_HARDENING]
                        This parameter skips the hardening part.

                        Hardening:
                          - Firewall
                          - Operating System
                          - SSH
                          - Apache
                          - nginx

                        ---------------------------------------------------------------
  -sU [SKIP_URLS], --skip-urls [SKIP_URLS]
                        This parameter skips the url opening part after the
                        installation process.
                                            
                        ---------------------------------------------------------------
  -tP TOOL_PATH, --tool-path TOOL_PATH
                        This parameter specifies your default tools location.

                        Default:
                          - /opt/pentest_tools
                          - /opt/forensic_tools

                        ---------------------------------------------------------------
  -v [VERBOSE], --verbose [VERBOSE]
                        This parameter shows all interaction messages during the apt
                        package manager installation process.

                        ---------------------------------------------------------------
```

<a name="category_install"></a>
## ⚔ Choose one of the six category types

After starting the program you should see the selection menu below, where you can now choose between several categories.

You can either use the `full name` of the category or the `number`.

<strong>Notice:</strong> Note that here you can only choose between `one` of the six categories.

```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.9                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


           Please choose between one category
----------------------------------------------------------
|                                                        |
| [1] complete    :  installation of both      toolkits  |
| [2] custom      :  installation of custom    tools     |
| [3] forensic    :  installation of forensic  tools     |
| [4] pentest     :  installation of pentest   tools     |
| [5] hardening   :  installation of hardening tools     |
| [6] training    :  installation of training  tools     |
|                                                        |
----------------------------------------------------------

Your Choice: pentest
```

<a name="pentesting_install"></a>
## ⚔ Choose between the Pentesting categories

In this chapter you have the possibility to choose between `one` or `multiple` pentesting areas.

Furthermore, you can take either the `full name` of the category or the `number`.

```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.9                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


           Please choose between one category
----------------------------------------------------------
|                                                        |
| [1] infrastructure  :   tools for infra  pentesting    |
| [2] iot             :   tools for iot    pentesting    |
| [3] mobile          :   tools for mobile pentesting    |
| [4] red_teaming     :   tools for red    teaming       |
| [5] web             :   tools for web    pentesting    |
| [6] cloud           :   tools for cloud  pentesting    |
|                                                        |
----------------------------------------------------------

Your Choice: infrastructure
```

You can take multiple categories in `number notation` as in the example below, use a `,` to separate them.

<strong>Notice:</strong> The same applies if you write out the name in full (e.g. `infrastructure,web`.

```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.9                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


           Please choose between one category
----------------------------------------------------------
|                                                        |
| [1] infrastructure  :   tools for infra  pentesting    |
| [2] iot             :   tools for iot    pentesting    |
| [3] mobile          :   tools for mobile pentesting    |
| [4] red_teaming     :   tools for red    teaming       |
| [5] web             :   tools for web    pentesting    |
| [6] cloud           :   tools for cloud  pentesting    |
|                                                        |
----------------------------------------------------------

Your Choice: 1,5
```

<a name="type_install"></a>
## ⚔ Choose one of the two installation types
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.7b                      💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


          Please choose between one installation
----------------------------------------------------------
|                                                        |
|  [1] full          :    full    installation (GUI)     |
|  [2] minimal       :    minimal installation (CLI)     |
|                                                        |
----------------------------------------------------------

Your Choice: full
```

<a name="hardening_install"></a>
## ⚔ Choose between the hardening options

In this chapter you can use the provided hardening measures, also here you have the possibility to choose either one or more settings.

<strong>Notice:</strong> If you want to skip this part in the future, use the parameter `-sH` when starting Yggdrasil.

```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.8                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀

----------------------------------------------------------
|                                                        |
| [1] complete         :   complete configuration        |
| [2] Firewall         :   firewall configuration        |
| [3] Sysctl (OS)      :   sysctl   hardening            |
| [4] SSH              :   SSH      hardening            |
| [5] Apache           :   Apache   hardening            |
| [6] nginx            :   nginx    hardening            |
|                                                        |
----------------------------------------------------------

Your Choice: 1
```

<a name="ssh_install"></a>
## ⚔ Configurate your SSH IP-Address

If you selected `Hardening for SSH` in the previous step, then you will be prompted to select one of the available local IP addresses.

```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.8                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


           Please select an IP address to be used
                   for SSH configuration
----------------------------------------------------------

     eth0: 
       -  192.168.56.2 (IPv4)
       -  fe80::XXX:XXXX:XXXX:XXXX (IPv6)
----------------------------------------------------------

Your Choice: 192.168.56.2

```

<a name="best_practice_settings"></a>
## ⚔ Choose between the provided best practice settings

Here you can use the best practice settings, also here it is possible that several can be selected.

<strong>Notice:</strong> If you want to skip this part in the future, use the parameter `-sC` when starting Yggdrasil.

```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.9                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


-----------------------------------------------------------
|                                                         |
|  [1] complete      :   complete configuration           |
|  [2] updates       :   automated updates                |
|                        (APT|Docker|Git Packages|Pip)    |
|  [3] alias         :   custom configs                   |
|                        (alias|.bashrc|.zshrc)           |
|  [4] screenrc      :   custom screenrc config           |
|  [5] vim           :   custom vim config                |
|  [6] repo          :   kali repository change           |
|  [7] shredder      :   workspace file shredding script  |
|                        (after 90 days [default])        |
|                                                         |
-----------------------------------------------------------

Your Choice: 1
```

<a name="task_settings"></a>
## ⚔ Choose between one of the two task settings

If you have selected either the `Updater` or the `Shredder` function, you will be redirected to the page below where you have the choice of creating the automated tasks as either a `Cronjob` or `Systemd Unit`.

```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.9                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


-----------------------------------------------------------
|                                                         |
|  [1] cronjob      :   cronjob configuration             |
|  [2] timer        :   systemd timer configuration       |
|                                                         |
-----------------------------------------------------------

Your Choice: 1

```

<a name="example_install_process"></a>
## ⚔ Installation Process

In the next step, the script will go through all the configured steps and install the tools like in the example below.

<p align=center>
    <img src="https://github.com/Jarl-Bjoern/Jarl-Bjoern/blob/main/Screencasts/yggrdasil_installation.gif" width=958 height=608>
</p>

<br />

<a name="automated_install"></a>
## 🔧 Using the automated variant

If you are already familiar with the program, then you can also run it completely automatically using the `cat <<EOF` command.

```bash
# Automated Variant text based without Hardening
cat <<EOF | sudo python3 /opt/Yggdrasil/yggdrasil.py -sH
pentest
infrastructure
full
complete
cronjob
EOF

# Automated Variant without Hardening with numbers
cat <<EOF | sudo python3 /opt/Yggdrasil/yggdrasil.py -sH
4
1
1
1
1
EOF

# Automated Variant with multiple pentesting categories without Hardening with numbers
cat <<EOF | sudo python3 /opt/Yggdrasil/yggdrasil.py -sH
4
1,5
1
1
EOF
```

<br /><strong>Notice:</strong> Make sure that if you use the Complete installation from Hardening part, that you also specify the IP address for the SSH server, otherwise you will end up in an exception.

```bash
# Automated Variant with multiple pentesting categories text based
cat <<EOF | sudo python3 /opt/Yggdrasil/yggdrasil.py
pentest
infrastructure,web
complete
192.168.2.1
complete
cronjob
EOF

# Automated Variant with multiple pentesting categories with numbers
cat <<EOF | sudo python3 /opt/Yggdrasil/yggdrasil.py
4
1,5
1
192.168.2.1
1
1
EOF
```

<br />

<a name="useful_functions"></a>
# ⚙️ Useful provided functions
If you have chosen the provided `alias configuration`, you can use the aliases listed in the next chapter.

<a name="nmap_exclude"></a>
## ⚙️ Exclude local IP-Addresses within nmap scans
In some cases, for example, you may receive an entire network as a target, in which case your Kali machine may also be located. As a result, it would be possible that you discover yourself with multiple vulnerabilities, to avoid this, this feature was built.

Whenever nmap is called, all local addresses are automatically included as exclude parameters, so if you have a network (e.g. `192.168.30.0/24`) as target and your machine has the IP address `192.168.30.50`, this and also the local `IPv6 addresses` will be `ignored`.

```r
# Nmap 7.93 scan initiated Thu Feb 16 06:28:47 2023 as:
nmap --exclude 127.0.0.1,::1,192.168.30.50,fe80::20c:29ff:fe69:66b3,172.17.0.1 192.168.30.1

Nmap scan report for 192.168.30.1
Host is up (0.00054s latency).

...
```

<a name="manual_tool_updater"></a>
## ⚙️ Manual Tools Updater
In many cases it can happen that sometimes tools were downloaded via Github, which may not have been fully operational at that time, for this purpose automated tasks were also built, but they always start after `5 hours`.

To speed up the process and manually pull updates from the repos, the alias `git-tools-update` was created.

<p>
    <img src="https://github.com/Jarl-Bjoern/Jarl-Bjoern/blob/main/Screencasts/git_tools_update.gif" width=800 height=600>
</p>

Furthermore, a manual updater for the package manager `Cargo` has also been created, which can be called using `cargo-tools-update`.

![Demo](https://github.com/Jarl-Bjoern/Jarl-Bjoern/blob/main/Screencasts/cargo_update_tools.gif)

<strong>Important:</strong> Be careful not to remove the two files `update.info` and `update_cargo.info` from your installation directory, they contain the packages that will be updated.

Last but not least, in some cases an annoying message may appear from the `microcode`, which can be tried to be fixed using the provided alias `microcode-update`.

<strong>Notice:</strong> Only the tools installed by Yggdrasil are affected by an update.

<a name="manual_url_opener"></a>
## ⚙️ Manual URL Opener
In some cases, you may need certain URLs and lack the time to always set them up as home pages in the browser.

<br />

| Alias               | Description |
| ------------------- | ----------- |
| yggdrasil-education | This alias is used to load pages into their default browser, which can be used for training purposes. |
| yggdrasil-forensic  | This alias is used to load web pages into your browser that are relevant for forensic purposes. |
| yggdrasil-hardening | This alias is used to load web pages that are relevant for hardening purposes. |
| yggdrasil-osint     | This alias opens URLs that are relevant for OSINT. |

<br />

In addition, I have developed another tool <a href="https://github.com/Jarl-Bjoern/Tyr">TYR</a>, which also loads URLs automatically into the default browser. This is integrated by default in Yggdrasil if you have selected the `Penetration Testing` category `Web` during the installation.

<a name="manual_info_show"></a>
## ⚙️ Manual Yggdrasil Info show
After installing Yggdrasil you will get a colored output of minor information, sometimes it may be needed again, to ensure this, this feature was built.

With the alias `yggdrasil-info` the output can be given up as often as you like.

![Demo](https://github.com/Jarl-Bjoern/Jarl-Bjoern/blob/main/Screencasts/yggdrasil_info.gif)

<br />

<a name="custom_install"></a>
# 📝 Customize your installation
You can open up one of the configuration files and add your own tools to the list to customize it to your liking (Make sure that the heading must always begin with a `#`).

In this example we take the configuration file for `infrastructure penetration testing`, which can be found under the following path `Config/Linux/Pentest/Infrastructure/minimal.txt`

<strong>Notice:</strong> The `minimal.txt` is set for special installation, e.g. if you are designing internal penetration tests remotely and can only connect to your target system via SSH and have no way to use GUI-based applications unless X11 forwarding is available.

After opening the file `minimal.txt` with an editor of your choice, you will now see a number of tools that have already been defined for various package managers.

```bash
# APT
bloodhound
dhcpig
fcrackzip

...
```

In this example we add the tool `Feroxbuster` under the header `#APT`, now at the next start the added tool will be installed.

<strong>Notice:</strong> When inserting new tools, make sure that you add it to the correct section of the respective package manager.

```bash
# APT
bloodhound
dhcpig
fcrackzip
feroxbuster

.....
```
Now you can add more tools as you wish.

When you arrive at the `Wget` section, you need to see that they follow the structure below.
```
URL Name Method
```
1. Insert a `URL` in the `first position` and make sure that the links can be called with a direct download and are not provided with a timer.
2. Note the `name` of the program to the `second place`, this is necessary that the file is named with a simpler name during the download and thus it is also easier to filter.
3. In the `third place` now follows the `method`, what kind of format the file has and how the program should behave, for example to unpack an archive. A detailed list of the available methods follows in the next chapter.

<a name="method_install"></a>
## 📝 The following methods are available:
### Archive
With the `Archive` argument you specify that you are downloading an archive, which is then loaded into the provided Python script and unpacked.
```bash
# Wget
https://dl.pstmn.io/download/latest/linux64 Postman Archive
```
### DPKG
The argument `DPKG` is used to download a package, which will be imported/installed afterwards.
```bash
# Wget
https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb chrome DPKG
```
### Executeable
With `Executeable`, you specify that you are downloading an executable file that is for example downloadable via Github like kerbrute.
```bash
# Wget
https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 kerbrute Executeable
```
### Installer
The `Installer` argument specifies that you download an installation package like .msi, which is subsequently launched, as is done with the Soap UI ready, for example, if you use the template for web penetration testing.
```bash
# Wget
https://sh.rustup.rs rust Installer
```
### Extension
With the `Extension` argument you specify that a browser addon should be installed. This has already been implemented for the Web Penetration Testing Template, for example.

<strong>Notice:</strong> Currently this is only possible for Firefox.
```bash
# Wget
https://addons.mozilla.org/android/downloads/file/3616824/foxyproxy_standard-7.5.1.xpi foxyproxy Extension
```

<a name="custom_install_II"></a>
## 📝 Build from scratch
You can also build the file from scratch. To do this, navigate to the directory `Config/Linux/Custom` and edit the file `install.txt`
```bash
# APT

# Cargo

# Docker

# Gem

# Git

# Go

# Python

# Wget

# Wordlists
```

After that, start the tool and select the `Custom` category to use your self-created list.
```bash
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀                                                       💀
💀                      Yggdrasil                        💀
💀                     Version 0.9                       💀
💀           Rainer Christian Bjoern Herold              💀
💀                                                       💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀


           Please choose between one category
----------------------------------------------------------
|                                                        |
| [1] complete    :  installation of both      toolkits  |
| [2] custom      :  installation of custom    tools     |
| [3] forensic    :  installation of forensic  tools     |
| [4] pentest     :  installation of pentest   tools     |
| [5] hardening   :  installation of hardening tools     |
| [6] training    :  installation of training  tools     |
|                                                        |
----------------------------------------------------------

Your Choice: custom
```

<a name="customized_scripts"></a>
## 📝 Include Customized Scripts
In addition, it is also possible that you can place your own scripts or packages in the provided `Custom` directory or your own directory and use them in the installation script.

For this, you must use the parameter `-cP` in combination with the absolute path, as in the example below

<strong>Currently the following formats are available to install external scripts or packages:</strong>
  - Bash/Shell
  - DPKG

<a name="directory_install"></a>
## Example
```bash
python3 /opt/Yggdrasil/yggdrasil.py -cP /mnt/MY_DIRECTORY
```

<br />

<a name="special_thanks"></a>
# 🏆 Special thanks
In the context of the development of the tool, I would like to thank the following people for their contribution:
  - atreus92
  - cddmp
  - Explie
  - GhostActive
  - HomeSen
  - ikstream
  - janstarke
  - julion-m
  - pyxon73
  - SandySchoene
  - SecMyth

<br />

# ⚠️ Remark
It should be said that the scripts are still under development, but already allow an easier start to perform as a penetration tester or digital forensics, certain pre-settings.
