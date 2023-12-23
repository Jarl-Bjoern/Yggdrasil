<h1 align="center">💀 Yggdrasil 💀</h1>
<p align="center"></p>
<div align="center">
  <a href="https://www.kali.org/">
    <img alt="Kali 22-4" src="https://img.shields.io/badge/%20-Linux-1f425f.svg?logo=linux&logoColor=cyan" />
  </a>
  <a href="https://www.python.org/downloads/release/python-3110/">
    <img alt="python" src="https://img.shields.io/badge/python-3.11-blue.svg?logo=python&logoColor=cyan" />
  </a>
  <a href="https://visitor-badge.lithub.cc/badge?page_id=jarl-bjoern/yggdrasil.visitor-badge&left_text=visitors">
    <img alt="visitors" src="https://visitor-badge.lithub.cc/badge?page_id=jarl-bjoern/yggdrasil.visitor-badge&left_text=visitors" />
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

This tool is intended to simplify the setup of various tools and configuration of a kali machine after a fresh installation and save unnecessary time, so that a predefined list can be used in advance or you can also create your own.<br />

The name `Yggdrasil` comes from norse mythology and is the tree of life or world tree, here the name is quite appropriate for the concept of the program, as it is geared for several pentetration test areas or even for digital forensics.<br />

<strong>Please do `not` use the program `for illegal intentions`.</strong><br />
<br />

## ❗ News
<strong>Upcoming changes for version</strong> `0.9c`:
  - Added Two New Features:
      - The installation path `Default: /opt/pentest_tools` will be now monitored if there are new tools added from github. If this is the case, then these are added to Update.info so that they are also updated automatically, regardless of whether they are integrated in the toolset of Yggdrasil.
      - If a tool is no longer in the installation path `Default: /opt/pentest_tools`, it will be deleted from `update.info` via a task.
  - Code Improvements:
    - The program will no longer terminate if an incorrect entry is made (the loop starts after the `main category` was selected).
  - Hotfixes:
    - Cronjobs & Systemd Units:
      - Due to a programming error, the Systemd units could not be used without the data shredder.
      - The cron jobs were not triggered as larger commands could not be used due to the complexity.
      - The times of the cronjobs have been adjusted.
      - External scripts `Location: /etc/yggdrasil` have now been created for both variants, which are called as a replacement.
    - DPKG Installer
    - Grammatical Errors:
      - Correction of `Executable` on all configs and the logic in the script.
    - Veracrypt Installation
  - New Aliases:
    - `kali-repo-switch` has been integrated, which can be used to switch between the two repositories `kali-rolling` and `kali-last-snapshot`.
    - `ls_old` was added to use the old `ls` instead of `exa`.
    - `sslyze` was added to scan tls with all parameters (thx to `@HomeSen`).
  - New Categories:
    - Development:
      - `source code analysis`
      - `reverse engineering`
      - `exploit development`
  - New Improvements:
    - Category improvements:
      - Forensics:
        - `Cloud`
        - `Crypto`
        - `Infrastructure`
        - `Mobile`
    - Yggdrasil Wiki improvements:
        - `Cheat Sheet`
        - `Features Overview`
        - `Tools Overview`
        - `Tools Usage`
        - `Useful Provided Functions`
  - New Parameters:
    - `-sI` was integrated to skip the installation way to use e.g. the hardening or custom configs.
 

<div align="center">
➡️ <a href="https://github.com/Jarl-Bjoern/Yggdrasil/blob/main/Information/Changelog/full.md">
  Full Changelog
</a> ⬅️
</div><br />


## 🛡️ Official Documentation
The official documentation on the tool can be found at the following link.

<div align="center">
➡️ <a href="https://github.com/Jarl-Bjoern/Yggdrasil/wiki">
  Official Documentation
</a> ⬅️
</div><br />


## 📃 Features
The following link lists all the features that the tool offers.

<div align="center">
➡️ <a href="https://github.com/Jarl-Bjoern/Yggdrasil/wiki/%F0%9F%93%83-Features-overview">
  List of all features
</a> ⬅️
</div><br />


## ⚔ Live Example
<p align=center>
    <img src="https://github.com/Jarl-Bjoern/Jarl-Bjoern/blob/main/Screencasts/yggrdasil_installation.gif" width=700 height=500>
</p>

<br />


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
