# BBR Management Script for Remnawave

A simple script to enable or disable BBR TCP congestion control on Linux servers, optimized for Remnawave nodes.

## Quick Install

Run the following command to install and run the script:

```bash
wget -N --no-check-certificate https://raw.githubusercontent.com/PedroLiu1999/bbr/main/bbr.sh && chmod +x bbr.sh && ./bbr.sh status
```

## Usage

Once installed, you can use the script with the following commands:

### Enable BBR
```bash
sudo ./bbr.sh enable
```

### Disable BBR
```bash
sudo ./bbr.sh disable
```

### Check Status
```bash
sudo ./bbr.sh status
```

## Requirements
- Linux Kernel 4.9 or higher
- Root privileges
