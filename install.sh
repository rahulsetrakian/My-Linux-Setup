#!/usr/bin/env bash
set -e

echo "[+] Updating system..."
sudo apt update && sudo apt install -y $(cat packages.txt)

echo "[+] Creating config directories..."
mkdir -p ~/.config/{hypr,waybar,kitty,dunst}

echo "[+] Installing configs..."
cp -r config/hypr/* ~/.config/hypr/
cp -r config/waybar/* ~/.config/waybar/
cp -r config/kitty/* ~/.config/kitty/
cp -r config/dunst/* ~/.config/dunst/

echo "[+] Done."
echo "Log out and select Hyprland from the login screen."
