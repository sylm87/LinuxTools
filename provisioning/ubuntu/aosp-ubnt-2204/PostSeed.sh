#!/bin/bash
echo "Script postinstalación OK" > /root/resultado.txt
apt update && apt install -y neofetch