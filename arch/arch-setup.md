Arch Linux + Hyprland + Pentest Tools (Windows 11 Host)

This guide covers the installation of Arch Linux, configuring the Hyprland tiling window manager for VMware on a Windows 11 host, and installing the BlackArch penetration testing repository.

1. VMware Workstation Settings (Windows 11 Specifics)

Crucial: Before booting the ISO, ensure these settings are applied to the VM to prevent lag and graphics glitches.

Software: Use VMware Workstation Pro (Now free for personal use) or Player.

Guest OS: Linux -> Arch Linux (64-bit)

Firmware: UEFI

3D Acceleration: Enabled (Mandatory for Hyprland) -> Settings > Display > Accelerate 3D graphics.

Note: Ensure "Graphics Memory" is set to 2GB or recommended max.

Performance Tweak (Critical): Go to Settings > Options > Advanced and check "Disable side channel mitigations for Hyper-V enabled hosts". This significantly improves performance on Windows 11.

Memory: 4GB minimum (8GB+ recommended).

Processors: 4+ cores recommended.

2. Base Arch Installation

Boot the Arch Linux ISO.

Verify internet connection: ping archlinux.org

Run the guided installer (fastest method):

archinstall


Recommended Selections:

Profile: Desktop > Hyprland

Graphics Driver: VMware / VMWare (vmvga/vmwgfx)

Audio: Pipewire

Network: NetworkManager

Bootloader: GRUB

Reboot after installation.

3. VMware Drivers & Tools

Install the necessary tools for clipboard sharing (copy/paste from Windows), resolution scaling, and 3D rendering.

# Update system and install tools
sudo pacman -Syu
sudo pacman -S open-vm-tools mesa xf86-video-vmware vulkan-swrast gtk3

# Enable the VMware tools daemon
sudo systemctl enable --now vmtoolsd


4. Hyprland Configuration (VM Fixes)

Hyprland often has an invisible cursor or rendering issues in VMs. You must add environment variables to fix this.

Open the config file:

nano ~/.config/hypr/hyprland.conf


Add these lines to the top of the file:

# --- VM COMPATIBILITY FIXES ---
env = WLR_NO_HARDWARE_CURSORS,1
env = WLR_RENDERER_ALLOW_SOFTWARE,1

# --- INPUT ---
input {
    follow_mouse = 1
    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

# --- MONITOR ---
# Replace 1920x1080 with your actual resolution (e.g. 2560x1440)
monitor = Virtual-1, 1920x1080@60, 0x0, 1

# --- WINDOWS HOST KEY FIX ---
# If the Windows key opens the Start Menu on host,
# use Alt as mod key OR use VMware "Exclusive Mode".
# $mainMod = SUPER


5. Installing BlackArch (Pentest Tools)

Add the BlackArch repository to access thousands of security tools on top of your existing Arch install.

Download the bootstrap script:

curl -O [https://blackarch.org/strap.sh](https://blackarch.org/strap.sh)


Make it executable and run it:

chmod +x strap.sh
sudo ./strap.sh


Update the package database:

sudo pacman -Syu


6. Installing Tools

You can now install tools individually or by category.

List all BlackArch categories:

sudo pacman -Sg | grep blackarch


Install common categories:

# Web Application Analysis
sudo pacman -S blackarch-webapp

# Scanners
sudo pacman -S blackarch-scanner

# Fuzzers
sudo pacman -S blackarch-fuzzer


Install specific tools:

sudo pacman -S burpsuite metasploit wireshark-qt


7. Optional: Terminal & UI

Recommended additions for a better Hyprland experience.

# Install Kitty (terminal), Waybar (status bar), Wofi (launcher)
sudo pacman -S kitty waybar wofi ttf-jetbrains-mono-nerd
