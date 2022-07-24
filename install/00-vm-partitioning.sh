#!/bin/bash

## Please enable UEFI first

PART=  # /dev/vda for qemu, /dev/sda for VirtualBox

if [ -z "$PART" ]; then
    read -r -p "Please choose the partition name: " PART
fi

parted "$PART" -- mklabel gpt

parted "$PART" -- mkpart ESP fat32 1MiB 513MiB
parted "$PART" -- mkpart primary 513MiB 100%

lsblk

mkfs.vfat "${PART}p1"

# Informing the Kernel of the changes.
echo "Informing the Kernel about the disk changes."
partprobe "$PART"
