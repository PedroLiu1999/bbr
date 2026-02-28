A simple script to enable or disable BBR TCP congestion control on Linux servers, optimized for Remnawave nodes.

## Features
- **One-click Enable**: Automatically configures `fq` and `bbr` for improved network performance.
- **Dynamic Recovery**: Automatically backs up your original system settings (`cubic`, `fq_codel`, etc.) to `/etc/.bbr_defaults` the first time you enable BBR.
- **Safe Disable**: Restores your exact original defaults when disabling, rather than using hardcoded values.
- **Status Check**: Easily verify your current congestion control and qdisc settings.
- **Easy Uninstall**: Completely remove the script and backup file with a single command.

## Quick Install

Run the following command to install the script system-wide:

```bash
sudo wget -O /usr/local/bin/bbr --no-check-certificate https://raw.githubusercontent.com/PedroLiu1999/bbr/main/bbr.sh && sudo chmod +x /usr/local/bin/bbr
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

### Uninstall
```bash
sudo bbr uninstall
```

## Requirements
- Linux Kernel 4.9 or higher
- Root privileges
