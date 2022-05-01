#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Not enough arguments provided"
    echo "Usage: $0 VM_ID EXPAND_BY_GB"
    echo "Example: $0 100 20G"
    exit 1
fi

apt install kpartx -qq > /dev/null

VM_ID=$1
NEW_SIZE=$2
DISK_NAME=$(qm config $1 | grep scsi0: | awk '{split($2,a,":|,");print a[1]}')
VIRTUAL_DISK_NAME=$(qm config $1 | grep scsi0: | awk '{split($2,a,":|,");print a[2]}')
VIRTUAL_DISK_PATH="/dev/${DISK_NAME}/${VIRTUAL_DISK_NAME}"

echo VM: ${VM_ID}
echo DISK: ${DISK_NAME}
echo NEW SIZE: ${NEW_SIZE}

qm resize $VM_ID scsi0 +${NEW_SIZE}
kpartx -av ${VIRTUAL_DISK_PATH}
sgdisk ${VIRTUAL_DISK_PATH} -e
kpartx -d ${VIRTUAL_DISK_PATH}
