#!/bin/bash

# Variables
COVENANT_PATH=""

# Main
if [ -d "$1" ]; then
    if [[ ! "$1" =~ "Covenant" ]]; then
        if [[ $(find "$1" -type d -name "Covenant") ]]; then
            COVENANT_PATH=$(find "$1" -type d -name "Covenant")
        else
            echo -e "Covenant was not found.\n\nPlease try again." ; exit
        fi
    fi

    if [[ "$COVENANT_PATH" != "" ]]; then
        cd "$COVENANT_PATH"
        docker build -t covenant .
        docker run -it -d -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v "$COVENANT_PATH"/Data:/app/Data covenant
    fi
else
    echo -e "Covenant was not found.\n\nPlease try again." ; exit
fi
