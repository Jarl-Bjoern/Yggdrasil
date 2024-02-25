#!/bin/bash

curl -s https://sliver.sh/install | sudo bash

cat <<EOF | sliver
armory install all
y
exit
EOF
