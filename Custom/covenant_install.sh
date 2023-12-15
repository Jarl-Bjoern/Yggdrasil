#!/bin/bash

if [ -d "/opt/pentest_tools/Covenant" ]; then
  cd /opt/pentest_tools/Covenant/Covenant
  docker build -t covenant .
  docker run -it -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v /opt/pentest_tools/Covenant/Covenant/Data:/app/Data covenant
fi
