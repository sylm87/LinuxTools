#!/bin/bash

# Authors: J0nan / n0t4u / sylm87
# Version: 1.0.0
# Description: Automatic installation of hacking tools on Kali

DEBIAN_FRONTEND=noninteractive

# Source: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# Regular Colors
Red='\033[0;31m'		# Red
Green='\033[0;32m'		# Green
Yellow='\033[0;33m'		# Yellow
Blue='\033[0;34m'		# Blue
ColorOff='\033[0m'		# Text Reset


# Download backgrounds SYLM87
mkdir -p /usr/share/backgrounds/sylm87
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/background1.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/background1.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/background2.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/background2.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/background3.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/background3.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/background4.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/background4.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/background5.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/background5.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/background6.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/background6.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/background7.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/background7.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/background8.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/background8.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/login.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/login.png
wget --no-check-certificate -O /usr/share/backgrounds/sylm87/login2.png https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/fondos/login2.png


# Basic apt tools
apt install nmon nload htop glances -y

# Setup
# Configuration of the terminal 
mkdir -p /home/kali/.config/qterminal.org
wget --no-check-certificate -O /home/kali/.config/qterminal.org/qterminal.ini https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/qterminal.ini
wget --no-check-certificate -O /home/kali/.config/qterminal.org/qterminal_bookmarks.xml https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/qterminal_bookmarks.xml
chown -R kali:kali /home/kali/.config/qterminal.org

# Power manager XFCE in user kali
# Disabling power safe, blank screen and switch-off in the monitor
mkdir -p /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml
wget --no-check-certificate -O /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/xfce4-power-manager.xml
chown -R kali:kali /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml
chmod 664 /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml

# Setup background in XFCE kali user
wget --no-check-certificate -O /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/xfce4-desktop.xml
chown -R kali:kali /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
chmod 664 /home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

# Setup background in XFCE login
wget --no-check-certificate -O /etc/lightdm/lightdm-gtk-greeter.conf https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/lightdm-gtk-greeter.conf
chmod 664 /etc/lightdm/lightdm-gtk-greeter.conf

# Setup config for Terminator terminal
apt install terminator -y
mkdir -p /home/kali/.config/terminator
chown -R kali:kali /home/kali/.config/terminator
wget --no-check-certificate -O /home/kali/.config/terminator/config https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/terminator_config
chown -R kali:kali /home/kali/.config/terminator/config
chmod 664 /home/kali/.config/terminator/config
wget --no-check-certificate -O /home/kali/.config/xfce4/helpers.rc https://raw.githubusercontent.com/sylm87/LinuxTools/refs/heads/main/provisioning/kali/generic/helpers.rc
chown -R kali:kali /home/kali/.config/xfce4/helpers.rc
chmod 664 /home/kali/.config/xfce4/helpers.rc


# Change hostname to kali due to vbox changing it
current_hostname=$(hostname)
if [ "$current_hostname" == "vbox" ]; then
  echo "${Blue}[*] Current hostname is 'vbox'. Changing it to 'kali'...${ColorOff}"
  hostnamectl set-hostname kali
  sed -i 's/vbox/kali/g' /etc/hosts
  echo "kali" | sudo tee /etc/hostname > /dev/null
fi

# General purpose tools
# Python3 and PIP3
echo -e "${Blue}[*] Installing python3 ${ColorOff}"
apt install python3 python3-venv -y

# git
echo -e "${Blue}[*] Installing git${ColorOff}"
apt install git -y

# Go
echo -e "${Blue}[*] Installing go and dependencies (BETA)${ColorOff}"
apt install golang-go -y
go env -w GOBIN="/opt/go/bin"
echo -en 'export PATH="$PATH:/usr/local/go/bin:/opt/go/bin"\ngo env -w GOBIN="/opt/go/bin"' >>/etc/profile

# Docker + docker compose
apt remove docker.io docker-compose -y
apt update
apt install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "bookworm") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl disable docker.service
systemctl disable docker.socket
usermod -a -G docker kali

# Snapd
apt install snapd -y
systemctl enable snapd --now
ln -s /var/lib/snapd/snap /usr/bin/snap

# SecLists
echo -e "${Blue}[*] Downloading dictionaries from SecLists${ColorOff}"
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists

# Dig and Nslookup
echo -e "${Blue}[*] Installing dnsutils (dig, nslookup)${ColorOff}"
apt install dnsutils -y

# Dbeaver
mkdir -p /tmp/Downloads
wget --no-check-certificate -O /tmp/Downloads/dbeaber-ce.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
apt install /tmp/Downloads/dbeaber-ce.deb -y
rm /tmp/Downloads/dbeaber-ce.deb

# Web applications tools
# Nuclei
echo -e "${Blue}[*] Installing nuclei${ColorOff}"
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Interactsh
echo -e "${Blue}[*] Installing interactsh${ColorOff}"
go install github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest

# Testssl.sh
echo -e "${Blue}[*] Installing testssl${ColorOff}"
git clone https://github.com/drwetter/testssl.sh.git /opt/testssl
ln -s /opt/testssl/testssl.sh /usr/bin/testssl

# wafw00f
echo -e "${Blue}[*] Installing wafw00f${ColorOff}"
apt remove wafw00f -y
pipx install git+https://github.com/EnableSecurity/wafw00f.git
ln -s /.local/share/pipx/venvs/wafw00f/bin/wafw00f /usr/bin/wafw00f

# httpx
echo -e "${Blue}[*] Installing httpx${ColorOff}"
apt remove httpx -y
go install github.com/projectdiscovery/httpx/cmd/httpx@latest

# Dirb
echo -e "${Blue}[*] Installing dirb${ColorOff}"
apt install dirb -y

# Gobuster
echo -e "${Blue}[*] Installing gobuster${ColorOff}"
apt install gobuster -y

# AMASS
echo -e "${Blue}[*] Installing AMASS${ColorOff}"
apt install amass -y

# Subfinder
echo -e "${Blue}[*] Installing subfinder${ColorOff}"
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Arjun
echo -e "${Blue}[*] Installing arjun${ColorOff}"
pipx install arjun
ln -s /.local/share/pipx/venvs/arjun/bin/arjun /usr/bin/arjun

# ffuf
echo -e "${Blue}[*] Installing ffuf${ColorOff}"
apt install ffuf -y 

# Bypass-403
echo -e "${Blue}[*] Installing Bypass-403${ColorOff}"
git clone https://github.com/iamj0ker/bypass-403 /opt/bypass-403
chmod +x /opt/bypass-403/bypass-403.sh
ln -s /opt/bypass-403/bypass-403.sh /usr/bin/bypass-403

# Corsy
echo -e "${Blue}[*] Installing Corsy${ColorOff}"
git clone https://github.com/s0md3v/Corsy /opt/corsy
python3 -m venv /opt/corsy
/opt/corsy/bin/python /opt/corsy/bin/pip install -r /opt/corsy/requirements.txt
chmod +x /opt/corsy/corsy.py
ln -s /opt/corsy/corsy.py /usr/bin/corsy

# EyeWitness
echo -e "${Blue}[*] Installing EyeWitness${ColorOff}"
apt install eyewitness -y

# Caido
latest_release_caido=$(curl -s "https://api.github.com/repos/caido/caido/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
URL_DEB_CAIDO="https://caido.download/releases/${latest_release_caido}/caido-desktop-${latest_release_caido}-linux-x86_64.deb"
wget --no-check-certificate -O /tmp/caido.deb ${URL_DEB_CAIDO}
apt install /tmp/caido.deb -y

# Infrastructure tools
# Onesixtyone (SNMP)
echo -e "${Blue}[*] Installing onesixtyone${ColorOff}"
apt remove onesixtyone -y
git clone https://github.com/trailofbits/onesixtyone.git /opt/onesixtyone
gcc -o /opt/onesixtyone/onesixtyone /opt/onesixtyone/onesixtyone.c
ln -s /opt/onesixtyone/onesixtyone /usr/bin/onesixtyone

# dnsrecon
echo -e "${Blue}[*] Installing dnsrecon${ColorOff}"
apt install dnsrecon

# domain_analyzer
echo -e "${Blue}[*] Installing domain_analyzer${ColorOff}"
git clone https://github.com/eldraco/domain_analyzer.git /opt/domain_analyzer
python3 -m venv /opt/domain_analyzer
/opt/domain_analyzer/bin/python /opt/domain_analyzer/bin/pip install -r /opt/domain_analyzer/requirements.txt
chmod +x /opt/domain_analyzer/domain_analyzer.py
ln -s /opt/domain_analyzer/domain_analyzer.py /usr/bin/domain_analyzer

# dnsmasq
echo -e "${Blue}[*] Installing dnsmasq${ColorOff}"
apt install dnsmasq -y

# SSH-Audit
echo -e "${Blue}[*] Installing ssh-audit${ColorOff}"
git clone https://github.com/jtesta/ssh-audit /opt/ssh-audit
chmod +x /opt/ssh-audit/ssh-audit.py
ln -s /opt/ssh-audit/ssh-audit.py /usr/bin/ssh-audit

# Terrapin-Scanner
echo -e "${Blue}[*] Installing Terrapin-Scanner${ColorOff}"
go install github.com/RUB-NDS/Terrapin-Scanner@latest

# JexBoss
echo -e "${Blue}[*] Installing JexBoss${ColorOff}"
git clone https://github.com/joaomatosf/jexboss.git /opt/jexboss
python3 -m venv /opt/jexboss
/opt/jexboss/bin/python /opt/jexboss/bin/pip install -r /opt/jexboss/requires.txt
ln -s /opt/jexboss/jexboss.py /usr/bin/jexboss

# SSLScan
echo -e "${Blue}[*] Installing SSLScan${ColorOff}"
apt install sslscan -y

# Mobile Tools
# Jadx
echo -e "${Blue}[*] Installing jadx${ColorOff}"
apt install jadx -y

# Google Android Tools
echo -e "${Blue}[*] Installing Google Android Tools${ColorOff}"
apt install google-android-platform-tools-installer -y

# WiFi tools
# Airgeddon
echo -e "${Blue}[*] Installing Airgeddon${ColorOff}"
git clone --depth 1 https://github.com/v1s1t0r1sh3r3/airgeddon.git /opt/airgeddon
chmod +x /opt/airgeddon/airgeddon.sh
ln -s /opt/airgeddon/airgeddon.sh /usr/bin/airgeddon

# Cracking
# COOK
echo -e "${Blue}[*] Installing COOK${ColorOff}"
go install github.com/glitchedgitz/cook/v2/cmd/cook@latest



