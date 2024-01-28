#!/bin/bash

# Variables
COVENANT_PATH=""

# Main
if [ -d "$1" ]; then
    if [[ ! "$1" =~ "Covenant" ]]; then
        if [[ $(find "$1" -type d -name "Covenant" | grep -v "Empire" | head -n1) ]]; then
            COVENANT_PATH=$(find "$1" -type d -name "Covenant" | grep -v "Empire" | head -n1)
        else
            echo -e "Covenant was not found.\n\nPlease try again." ; exit
        fi
    fi

    if [[ "$COVENANT_PATH" != "" ]]; then
        if [[ $(docker ps -a | grep -E "covenant|Covenant") ]]; then
            echo -e "covenant already exists. should it removed and rebuild?\n"
            read -p "decision (y/n): " decision
            if [[ $decision == "y" || $decision == "Y" ]]; then
                docker stop covenant || docker stop Covenant
                docker rm covenant || docker rm Covenant
            else
                exit
            fi
        fi
        cd "$COVENANT_PATH/Covenant"
        docker build -t covenant .
        docker run -it -d -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v "$COVENANT_PATH"/Covenant/Data:/app/Data covenant
    fi
else
    echo -e "Covenant was not found.\n\nPlease try again." ; exit
fi
