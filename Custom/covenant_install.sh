#!/bin/bash
# Rainer Christian Bjoern Herold

# Variables
COVENANT_PATH=""

# Main
if [ -d "$1" ]; then
    if [[ ! "$1" =~ "Covenant" ]]; then
        if [[ $(find "$1" -type d -name "Covenant" | grep -v "Empire" | head -n1) ]]; then
            COVENANT_PATH=$(find "$1" -type d -name "Covenant" | grep -v "Empire" | head -n1)
        else
            echo -e "Covenant was not found inside the path.\n\nPlease try again." ; exit
        fi
    fi

    if [[ "$COVENANT_PATH" != "" ]]; then
        if [[ $(docker ps -a | grep -E "covenant|Covenant") ]]; then
            echo -e "Covenant already exists. Should it be removed and rebuilt?\n"
            read -p "decision (y/n): " decision
            if [[ $decision == "y" || $decision == "Y" ]]; then
                docker stop covenant || docker stop Covenant
                docker rm covenant || docker rm Covenant
                cd "$COVENANT_PATH/Covenant"
                docker build -t covenant .
                docker run -it -d -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v "$COVENANT_PATH"/Covenant/Data:/app/Data covenant
            elif [[ $decision == "n" || $decision == "N" ]]; then
                echo "Covenant will not be removed."
            else
                echo "The decision was not accepted." ; exit
            fi
        else
            cd "$COVENANT_PATH/Covenant"
            docker build -t covenant .
            docker run -it -d -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v "$COVENANT_PATH"/Covenant/Data:/app/Data covenant
        fi
    fi
else
    echo -e "Covenant was not found inside the path.\n\nPlease try again." ; exit
fi
