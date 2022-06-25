#!/bin/bash

if [ ! -d "/usr/local/bin" ]; then
  mkdir -p /usr/local/bin
fi

# if /usr/local/bin/expand-disk exists, then remove it

if [ -f "/usr/local/bin/expand-disk" ]; then
  rm /usr/local/bin/expand-disk
fi

curl -sS -o /usr/local/bin/expand-disk https://raw.githubusercontent.com/fire1ce/proxmox-vm-disk-expander/main/expand.sh

# if the download was successful, then make the file executable else exit
if [ -f "/usr/local/bin/expand-disk" ]; then
  chmod +x /usr/local/bin/expand-disk
  printf "\nproxmox-vm-disk-expander downloaded and installed successfully"
else
  printf "\nError: Download failed"
  exit 1
fi

# Print the usage
printf "\nUsage: expand-disk\n"
