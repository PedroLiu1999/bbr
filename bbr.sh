#!/bin/bash

# BBR Management Script for Remnawave Node
# Author: PedroLiu1999

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function check_root() {
    if [[ $EUID -ne 0 ]]; then
       echo -e "${RED}Error: This script must be run as root${NC}"
       exit 1
    fi
}

function check_kernel() {
    kernel_version=$(uname -r | cut -d- -f1)
    if [[ $(echo -e "$kernel_version\n4.9" | sort -V | head -n1) != "4.9" ]]; then
        echo -e "${RED}Error: Kernel version $kernel_version is too old. BBR requires kernel 4.9 or higher.${NC}"
        exit 1
    fi
}

function get_status() {
    current_cc=$(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}')
    current_fq=$(sysctl net.core.default_qdisc | awk '{print $3}')
    
    echo -e "Current TCP Congestion Control: ${GREEN}$current_cc${NC}"
    echo -e "Current Default Qdisc: ${GREEN}$current_fq${NC}"
    
    if [[ "$current_cc" == "bbr" ]]; then
        echo -e "BBR Status: ${GREEN}Enabled${NC}"
    else
        echo -e "BBR Status: ${RED}Disabled${NC}"
    fi
}

function enable_bbr() {
    echo -e "Enabling BBR..."
    
    # Check if already enabled
    if [[ $(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}') == "bbr" ]]; then
        echo -e "${GREEN}BBR is already enabled.${NC}"
        return
    fi

    # Update sysctl.conf
    sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    
    echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
    
    sysctl -p > /dev/null
    
    echo -e "${GREEN}BBR enabled successfully!${NC}"
    get_status
}

function disable_bbr() {
    echo -e "Disabling BBR..."
    
    # Remove from config file
    sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    
    # Immediately revert kernel parameters to standard defaults
    sysctl -w net.core.default_qdisc=fq_codel > /dev/null 2>&1
    sysctl -w net.ipv4.tcp_congestion_control=cubic > /dev/null 2>&1
    
    # Reload remaining settings
    sysctl -p > /dev/null
    
    echo -e "${GREEN}BBR disabled successfully (configuration lines removed and kernel parameters reset).${NC}"
    get_status
}

function usage() {
    echo "Usage: $0 {enable|disable|status}"
    exit 1
}

# Main
check_root
check_kernel

case "$1" in
    enable)
        enable_bbr
        ;;
    disable)
        disable_bbr
        ;;
    status)
        get_status
        ;;
    *)
        usage
        ;;
esac
