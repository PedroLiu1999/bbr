# BBR Management Script for Remnawave

A simple script to enable or disable BBR TCP congestion control on Linux servers, optimized for Remnawave nodes.

## Quick Install

Run the following command to install the script system-wide:

```bash
sudo wget -O /usr/local/bin/bbr --no-check-certificate https://raw.githubusercontent.com/PedroLiu1999/bbr/main/bbr.sh && sudo chmod +x /usr/local/bin/bbr && bbr status
```

## Usage

Once installed, you can use the script from anywhere:

### Enable BBR
```bash
sudo bbr enable
```

### Disable BBR
```bash
sudo bbr disable
```

### Check Status
```bash
sudo bbr status
```

## Requirements
- Linux Kernel 4.9 or higher
- Root privileges
