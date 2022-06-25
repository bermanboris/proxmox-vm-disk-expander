#!/bin/bash

# Check if all the arguments are provided
if [ $# -lt 2 ]; then
  echo "Not enough arguments provided"
  echo "Usage: $0 VM_ID EXPAND_BY_GB"
  echo "Example: $0 100 20G"
  exit 1
fi

# Check if kpartx is installed otherwise install kpartx
if ! [ -x "$(command -v kpartx)" ]; then
  echo 'Installing kpartx dependency...'
  sudo apt-get install kpartx
fi

VM_ID=$1
NEW_SIZE=$2
DISK_NAME=$(qm config $1 | grep scsi0: | awk '{split($2,a,":|,");print a[1]}')
VIRTUAL_DISK_NAME=$(qm config $1 | grep scsi0: | awk '{split($2,a,":|,");print a[2]}')
VIRTUAL_DISK_PATH="/dev/${DISK_NAME}/${VIRTUAL_DISK_NAME}"

# get the current size of the disk
CURRENT_DISK_SIZE=$(qm list $VM_ID | grep $VIRTUAL_DISK_PATH | awk '{split($2,a,":|,");print a[1]}')
echo "Current disk size: $CURRENT_DISK_SIZE"

# Display red warning
echo VM: ${VM_ID} disk ${DISK_NAME} will be expanded by ${NEW_SIZE}
echo -e "\e[31mWarning: There is no way to downsize the disk \e[0m"

# Ask for confirmation
read -p "Are you sure you want to continue? (yes/no) " -n 1 -r

# if the user says yes, then continue otherwise exit
if [[ $REPLY =~ ^[yes]$ ]]; then
  echo "Expanding disk..."
  sudo qm resize $VM_ID scsi0 +${NEW_SIZE}
  sudo kpartx -av ${VIRTUAL_DISK_PATH}
  sudo sgdisk ${VIRTUAL_DISK_PATH} -e
  sudo kpartx -d ${VIRTUAL_DISK_PATH}
  echo "Expanding disk...done"
else
  echo "Exiting..."
  exit 1
fi
