#!/usr/bin/env bash
set -e

echo "[+] Updating system"
sudo apt update && sudo apt full-upgrade -y

echo "[+] Installing packages"
sudo apt install -y $(cat packages.txt)

echo "[+] Installing configs"
mkdir -p ~/.config
cp -r config/* ~/.config/

echo "[+] Enabling Wayland stability"
echo "export MOZ_ENABLE_WAYLAND=1" >> ~/.profile
echo "export GDK_BACKEND=wayland" >> ~/.profile

echo "[+] Done"
echo "Log out → select Hyprland session"
