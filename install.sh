#!/bin/bash

if [ ! -d "/usr/local/bin" ]; then
  mkdir -p /usr/local/bin
fi

# if /usr/local/bin/expand-disk exists, then remove it

if [ -f "/usr/local/bin/expand-disk" ]; then
  rm /usr/local/bin/expand-disk
fi

curl -s -o /usr/local/bin/expand-disk https://raw.githubusercontent.com/fire1ce/proxmox-vm-disk-expander/main/expand.sh

chmod +x /usr/local/bin/expand-disk
