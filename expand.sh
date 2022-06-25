#!/bin/bash

# Check if kpartx is installed otherwise install kpartx
if ! [ -x "$(command -v kpartx)" ]; then
  printf 'Installing kpartx dependency...'
  sudo apt-get install kpartx
fi

# # Check if all the arguments are provided
# if [ $# -lt 2 ]; then
#   printf "Not enough arguments provided"
#   printf "Usage: $0 VM_ID EXPAND_BY_GB"
#   printf "Example: $0 100 20G"
#   exit 1
# fi

# List of all the vm
qm list
# Promt the user to select the vm id to be expanded
read -p "Enter the VM ID to be expanded: " VM_ID
# Check if the VM id is valid
if [ -z "$(qm list | grep $VM_ID)" ]; then
  printf "\nInvalid VM ID"
  exit 1
fi

# promt the user to enter the size to be expanded
read -p "Enter the size to be expanded in GB (exmaple: 10g): " EXPAND_BY_GB
# Check if the size is valid
if [ -z "$(printf $EXPAND_BY_GB | grep -E '^[0-9]+[Gg]$')" ]; then
  printf "\nInvalid size"
  exit 1
fi

# VM_ID=$VM_ID
# EXPAND_BY_GB=$2
DISK_NAME=$(qm config $VM_ID | grep scsi0: | awk '{split($2,a,":|,");print a[1]}')
VIRTUAL_DISK_NAME=$(qm config $VM_ID | grep scsi0: | awk '{split($2,a,":|,");print a[2]}')
VIRTUAL_DISK_PATH="/dev/${DISK_NAME}/${VIRTUAL_DISK_NAME}"

# Display red warning
echo VM: ${VM_ID} disk ${DISK_NAME} will be expanded by ${EXPAND_BY_GB}
echo -e "\e[31mWarning: There is no way to downsize the disk \e[0m"

# Ask for confirmation
read -p "Are you sure you want to continue? (yes/no) " -n 1 -r

# if the user says yes, then continue otherwise exit
if [[ $REPLY =~ ^[Yy]$ ]]; then
  printf "\nExpanding the disk..."
  sudo kpartx -a $VIRTUAL_DISK_PATH
  sudo growpart /dev/${DISK_NAME} ${VIRTUAL_DISK_NAME}
  sudo resize2fs /dev/${DISK_NAME}${VIRTUAL_DISK_NAME}
  sudo kpartx -d $VIRTUAL_DISK_PATH
  # printf "Disk expanded successfully"
else
  printf "\nExiting..."
  exit 1
fi
