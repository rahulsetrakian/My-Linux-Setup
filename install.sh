#!/usr/bin/env bash

set -e

echo "[+] Updating system"
sudo apt update && sudo apt upgrade -y

echo "[+] Installing packages"
sudo apt install -y $(cat packages.txt)

echo "[+] Installing configs"
echo 'set backspace=indent,eol,start' >> ~/.vimrc
mkdir -p ~/.config
cp -r config/* ~/.config/

echo "[+] Done"
echo "Happy Hacking!"
