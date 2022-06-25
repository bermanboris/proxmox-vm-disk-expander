#!/bin/bash

if [ ! -d "/usr/local/bin" ]; then
  mkdir -p /usr/local/bin
fi

# Remove the old version of the script if it exists

if [ -f "/usr/local/bin/expand-disk" ]; then
  rm /usr/local/bin/expand-disk
fi

# Download the latest version of expand-disk
curl -sS -o /usr/local/bin/expand-disk https://raw.githubusercontent.com/bermanboris/proxmox-vm-disk-expander/main/expand.sh

# if the download was successful, then make the file executable else exit
if [ -f "/usr/local/bin/expand-disk" ]; then
  chmod +x /usr/local/bin/expand-disk
  printf "\nproxmox-vm-disk-expander downloaded and installed successfully"
else
  printf "\nError: Download failed"
  exit 1
fi

# Print the usage message
printf "\nUsage: expand-disk\n"
