sudo mkdir -p /opt/drivers ; cd /opt/drivers || return 0
sudo git clone https://github.com/AdnanHodzic/displaylink-debian
cd displaylink-debian || return 0
cat <<EOF | sudo bash displaylink-debian.sh
i
Y
Y
Y
Y
Y
Y
Y
n
EOF
