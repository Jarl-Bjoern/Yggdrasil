<h1 align="center">💀 Yggdrasil 💀</h1>
<p align="center"></p>
<div align="center">
  <a href="https://www.kali.org/">
    <img alt="Kali 22-4" src="https://img.shields.io/badge/%20-Linux-1f425f.svg?logo=linux&logoColor=cyan" />
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
<strong>Upcoming changes for version</strong> `0.9b`:
  - Logging fixes
  - Hotfix for missing installation path while using the custom category
  - Improved APT-Downloader
  - Improved Git-Tool Downloader
  - Improved rust updater
  - Improved red teaming category
  - Improved firewall settings
  - New alias for important pentesting url opening

<div align="center">
➡️ <a href="https://github.com/Jarl-Bjoern/Yggdrasil/blob/main/Information/Changelog/full.md">
  Full Changelog
</a> ⬅️
</div><br />

## 🛡️ Official Documentation
Under the link below you can find the official documentation on how to use the tool.

<div align="center">
➡️ <a href="https://github.com/Jarl-Bjoern/Yggdrasil/wiki">
  Official Documentation
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
  - Docker (normal | specific branch | submodules)
  - Gem
  - Github
  - Go
  - pip
- Best Practice settings
  - Automated cleaning tasks
    - cleaning task to remove old container images
    - shredding task to delete your penetration test results for privacy reasons after 90 days (default) or after a custom number of days
  - Automated Updater via Crontab
    - Cargo Tools
    - Docker Images
    - GIT Tools
    - Important pip packages
    - OS
    - Rust
  - Changing the default hostname
  - Custom configuration
    - BASHRC and ZSHRC
      - Alias
        - callable yggdrasil best practice information after the installation
        - colorized grep
        - human readable df & du commands
        - manual microcode update
        - manual git tools update
        - manual rust updater
        - nmap exclude for local ip addresses
        - url opener divided by categories (education | forensic | infrastructure | osint | pentesting)
      - Functions
        - base64 function
        - colorized file reader function
        - vnc start function
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
  - nayaningaloo
  - pyxon73
  - SandySchoene
  - SecMyth

But also the developer would like to thank the people who do not have a GitHub account and have helped the success of the tool in any way.

<br />

# ⚠️ Remark
It should be said that the scripts are still under development, but already allow an easier start to perform as a penetration tester or digital forensics, certain pre-settings.
