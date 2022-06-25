#!/bin/bash

# Check if kpartx is installed otherwise install kpartx
if ! [ -x "$(command -v kpartx)" ]; then
  echo 'Installing kpartx dependency...'
  apt-get install -y kpartx
fi

# List of all the vm
qm list

while true; do
  # Promt the user to select the vm id to be expanded
  read -p "Enter the VM ID to be expanded: " VM_ID
  
  # Check if the VM id is valid
  if [ -z "$(qm list | grep $VM_ID)" ]; then
    printf "\nInvalid VM ID"
  else
    break
  fi
done


while true; do
  # promt the user to enter the size to be expanded
  read -p "Enter the size to be expanded in GB (exmaple: 10G): " EXPAND_BY_GB

  # Check if the size is valid
  if [ -z "$(printf $EXPAND_BY_GB | grep -E '^[0-9]+[G]$')" ]; then
    printf "\nInvalid size. Please enter the size in GB (exmaple: 10G)"
  else
    break
  fi
done
  
  

# Set needed variables for expansion
DISK_NAME=$(qm config $VM_ID | grep scsi0: | awk '{split($2,a,":|,");print a[1]}')
VIRTUAL_DISK_NAME=$(qm config $VM_ID | grep scsi0: | awk '{split($2,a,":|,");print a[2]}')
VIRTUAL_DISK_PATH="/dev/${DISK_NAME}/${VIRTUAL_DISK_NAME}"

# Display warning
echo VM ID ${VM_ID} disk ${DISK_NAME} will be expanded by ${EXPAND_BY_GB}
echo -e "\e[31mWarning: There is no way to downsize the disk! \e[0m"

# Ask for confirmation "yes" and git enter to continue
read -p "Are you sure you want to expand the disk? (yes/no): " CONFIRM

# if the user says yes, then continue otherwise exit
if [ "$CONFIRM" = "yes" ]; then
  printf "\nExpanding the disk..."
  qm resize $VM_ID scsi0 +${EXPAND_BY_GB}
  kpartx -av ${VIRTUAL_DISK_PATH}
  sgdisk ${VIRTUAL_DISK_PATH} -e
  kpartx -d ${VIRTUAL_DISK_PATH}
else
  printf "\nExiting"
  exit 1
fi
