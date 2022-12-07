# TP-Link 821n V6
sudo apt install -y bc build-essential dkms firmware-realtek linux-headers-generic realtek-rtl8188eus-dkms 
sudo mkdir -p /opt/drivers ; cd /opt/drivers ; sudo git clone https://www.github.com/Mange/rtl8192eu-linux-driver ; cd rtl8192eu-linux-driver
sudo make &&
sudo make install &&
echo "rtl8192eu" > /etc/modprobe.d/blacklist.conf &&
echo "Installation completed"
