# TP-Link 821n V6
sudo apt install -y firmware-realtek realtek-rtl8188eus-dkms linux-headers-generic build-essential dkms
cd /opt ; git clone https://www.github.com/Mange/rtl8192eu-linux-driver ; cd /rtl8192eu-linux-driver
sudo make &&
sudo make install &&
echo "rtl8192eu" > /etc/modprobe.d/blacklist.conf &&
echo "Installation completed"
