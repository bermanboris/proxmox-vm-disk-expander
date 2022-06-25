#!/bin/bash

if [ ! -d "/usr/local/bin" ]; then
  mkdir -p /usr/local/bin
fi

curl -s -o /usr/local/bin/expand-disk https://raw.githubusercontent.com/fire1ce/proxmox-vm-disk-expander/main/expand.sh
