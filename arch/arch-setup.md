# Arch Linux + Hyprland + Pentest Tools (Windows 11 Host)

This guide covers installing **Arch Linux**, configuring the **Hyprland** tiling window manager for **VMware** on a **Windows 11 host**, and installing the **BlackArch** penetration testing repository.

---

## 1. VMware Workstation Settings (Windows 11 Specifics)

⚠️ **Crucial:** Before booting the ISO, apply these settings to prevent lag and graphics glitches.

- **Software:** VMware Workstation Pro (free for personal use) or Player  
- **Guest OS:** Linux → Arch Linux (64-bit)  
- **Firmware:** UEFI  
- **3D Acceleration:** Enabled  
  - `Settings > Display > Accelerate 3D graphics`
- **Graphics Memory:** Set to **2 GB** (or maximum recommended)

### Performance Tweak (Critical)
- `Settings > Options > Advanced`
- Enable: **Disable side channel mitigations for Hyper-V enabled hosts**

This dramatically improves performance on Windows 11.

- **Memory:** 4 GB minimum (8 GB+ recommended)  
- **Processors:** 4+ cores recommended  

---

## 2. Base Arch Installation

1. Boot the Arch Linux ISO
2. Verify internet connectivity:
   ```bash
   ping archlinux.org
   ```

3. Launch the guided installer:
   ```bash
   archinstall
   ```

### Recommended Selections
- **Profile:** Desktop → Hyprland  
- **Graphics Driver:** VMware (vmvga / vmwgfx)  
- **Audio:** PipeWire  
- **Network:** NetworkManager  
- **Bootloader:** GRUB  

Reboot after installation completes.

---

## 3. VMware Drivers & Tools

Install tools for clipboard sharing, resolution scaling, and 3D acceleration.

```bash
sudo pacman -Syu
sudo pacman -S open-vm-tools mesa xf86-video-vmware vulkan-swrast gtk3
```

Enable VMware services:

```bash
sudo systemctl enable --now vmtoolsd
```

---

## 4. Hyprland Configuration (VM Fixes)

VMs may suffer from invisible cursors or rendering issues.

Edit the config file:

```bash
nano ~/.config/hypr/hyprland.conf
```

Add **at the top**:

```ini
# --- VM COMPATIBILITY FIXES ---
env = WLR_NO_HARDWARE_CURSORS,1
env = WLR_RENDERER_ALLOW_SOFTWARE,1

# --- INPUT ---
input {
    follow_mouse = 1
    sensitivity = 0
}

# --- MONITOR ---
# Replace with your actual resolution (e.g. 2560x1440)
monitor = Virtual-1, 1920x1080@60, 0x0, 1

# --- WINDOWS HOST KEY FIX ---
# If SUPER opens Windows Start Menu:
# Use Alt as main modifier or enable VMware Exclusive Mode
# $mainMod = SUPER
```

---

## 5. Installing BlackArch (Pentest Tools)

Download the bootstrap script:

```bash
curl -O https://blackarch.org/strap.sh
```

Make it executable and run:

```bash
chmod +x strap.sh
sudo ./strap.sh
```

Update system:

```bash
sudo pacman -Syu
```

---

## 6. Installing Tools

### List BlackArch categories
```bash
sudo pacman -Sg | grep blackarch
```

### Install common categories

```bash
# Web application testing
sudo pacman -S blackarch-webapp

# Scanners
sudo pacman -S blackarch-scanner

# Fuzzers
sudo pacman -S blackarch-fuzzer
```

### Install specific tools

```bash
sudo pacman -S burpsuite metasploit wireshark-qt
```

---

## 7. Optional: Terminal & UI Enhancements

Recommended tools for a better Hyprland experience:

```bash
sudo pacman -S kitty waybar wofi ttf-jetbrains-mono-nerd
```

---

✅ **Result:**  
A smooth Arch Linux + Hyprland setup inside VMware on Windows 11, equipped with a full BlackArch pentesting environment.
