## Version 0.9c
<strong>Changes for version</strong> `0.9c`:
  - Added New Features:
      - The installation path `Default: /opt/pentest_tools` will be now monitored if there are new tools added from github. If this is the case, then these are added to Update.info so that they are also updated automatically, regardless of whether they are integrated in the toolset of Yggdrasil.
      - If a tool is no longer in the installation path `Default: /opt/pentest_tools`, it will be deleted from `update.info` via a task.
      - It is now also possible to download `hashcat rules` which can then be found in the `/opt/hashcat_rules` directory.
      - The new function `yggdrasil-custom` can now also be used to open custom URLs (the provided file `Default: /opt/yggdrasil/Information/Pages/Custom.txt` can be edited or an external file `yggdrasil-custom /home/kali/my_own_urls.txt` can be loaded).
      - The `table of contents` in the wiki has been made clearer. In addition, all links can now be accessed without having to select the top category of the page first.
      - An overview of the paths which was created by the tool will now displayed after the installation is complete.
  - Code Improvements:
    - The program will no longer terminate if an incorrect entry is made (the loop starts after the `main category` was selected).
    - The tools that are downloaded via `WGET` are now filtered dynamically so that they do not have to be hardcoded anymore. (However, this can lead to problems if the name inside the config is not the same which will be displayed after the installation inside the `/usr/bin` location - as a example `/usr/bin/chrome` will not be found because the correct installed package is called `/usr/bin/google-chrome`)
    - The tools that are downloaded via `GitHub` are now also checked to see if they are already installed locally in order to skip them and display the output during the installation process.
  - Hotfixes:
    - Cronjobs & Systemd Units:
      - Due to a programming error, the Systemd units could not be used without the data shredder.
      - The cron jobs were not triggered as larger commands could not be used due to the complexity.
      - The times of the cronjobs have been adjusted.
      - External scripts `Location: /etc/yggdrasil` have now been created for both variants, which are called as a replacement.
    - DPKG Installer
    - Grammatical Errors:
      - Correction of `Executable` on all configs and the logic in the script.
    - The URL opener should now no longer produce output inside the shell.
    - Tools that are installed via `Go` will get a rework so that the tool is downloaded via `git clone` and then installed via `go install`, as the `go get` command is no longer supported.
    - Veracrypt Installation
  - New Aliases / Functions:
    - `kali-repo-switch` has been integrated, which can be used to switch between the two repositories `kali-rolling` and `kali-last-snapshot`.
    - `ls_old` was added to use the old `ls` instead of `exa`.
    - `sslyze` was added to scan tls with all parameters (thx to `@HomeSen`).
    - `yggdrasil-web` was added to open some useful urls for web pentests.
    - `yggdrasil-custom` was added to open customized urls.
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
        - `Tool Usage`
        - `Useful Provided Functions`
        - `Using The Automated Variant`
  - New Parameters:
    - `-sI` was integrated to skip the installation way to use e.g. the hardening or custom configs.
    - `-sbI` was integrated to skip the installation process of the basic tools.
<br />

## Version 0.9b
<details><strong>Changes of version</strong> `0.9b`:
  - Added the tool exa as replace for ls with an new alias
  - Logging fixes
  - Hotfix for broken cargo installer
  - Hotfix for the path bug during the process for creating the file update.info
  - Hotfix for missing installation path while using the custom category
  - Hotfix for the shredding task
  - Improved APT-Downloader
  - Improved Git-Tool Downloader
  - Improved rust updater
  - Improved red teaming category
  - Improved firewall settings
  - Improved wget Downloader
  - Improved yggdrasil-info alias
  - New alias for clearing the terminal
  - New alias for important pentesting url opening
  - New feature to choose between one or multiple files while using the parameter -cP
  - New custom configs for screenrc and tmux
  - New tools was added to mulitple sections
  - Outsourcing of the documentation to the Yggdrasil wiki
</details>
<br />

## Version 0.9
<strong>Changes of version</strong> `0.9`:
  - new cleaning task for old container images inside the updater settings
  - several new aliases have been added to allow reopening of various important web pages, such as for further education, or the information that appears after installation
  - scalable number of days for the shredding task
  - function to use vnc inside the browser for remote gui applications
  - automated rust language updater
  - replacement of the dos2unix tool by a self-written converter
  - new parameter was added to skip the automated url opening process after the installation
  - automated URL opener for meaningful pages for example for pentesting
  - automated installer for firefox extensions
  - added new choice to choose between cronjobs or systemd timer for the automated updates
  - new installation categories was added
  - automated and manual updater for the cargo tools
  - new parameter was added to show interaction messages during the apt installation
  - reorganization of the repository
  - new menu to choose between two provided vim configurations
  - new menu for the best practice settings like vim configuration, crontab etc.
  - automated updater for the git tools
  - ability to choose your own installation directory
  - colorized information after the installation
  - manual update alias for the installed git tools and microcode update
  - added automated shredding task after 90 days for data privacy
  - updated README
  - added hardening options for apache and nginx
  - alias bugfixes for bashrc
  - new colors was added
  - suppressed usage message at the help section
  - the python files have been split up
  - logging bug fixes
  - bug and logical fixes

<strong>Known issues of </strong> `0.9`:
  - The logging is bugged
  - Rust still does not install correctly
  - Kali 23.1 doesn't include a preinstalled version of opencv-python
  - Shredding Script doesn't work correctly
<br />

## Version 0.8b
<strong>Hotfix</strong> `0.8b`:
  - the hostname changing function was now set to the end of the script
<br />

## Version 0.8a
<strong>Hotfix</strong> `0.8a`:
  - bug and logical fixes
<br />

## Version 0.8
<strong>Changes of version</strong> `0.8`:
  - custom workspace place via argument
  - overview about hardening options
  - colorized help menu
  - animated header
  - some new tools inside the config files
  - bug and logical fixes
  - filter option for webscanner tools
  - download logging function
<br />

## Version 0.7g
With version `0.7g` it is now possible to select multiple categories in pentesting for installation.
<br />

## Version 0.7
Since version `0.7` it is now possible to choose between the three categories `Complete`, `Forensic` and `Pentest`.
