# proxmox-vm-disk-expander

Interactive disk expander for Proxmox's VM disks (including the partition) from your Proxmox host cli.

## Curl Method

Run the script once without installing it.

```shell
bash <(curl -s https://raw.githubusercontent.com/fire1ce/proxmox-vm-disk-expander/main/expand.sh)
```

## Installer

Install the script at Proxmox host for multiple use.

Run the following command from Proxmox host:

```shell
curl -sS https://raw.githubusercontent.com/fire1ce/proxmox-vm-disk-expander/main/install.sh | bash
```

## Update

Same as the installer.

```shell
curl -sS https://raw.githubusercontent.com/fire1ce/proxmox-vm-disk-expander/main/install.sh | bash
```

## Example usage/output

```shell
╭─root@proxmox ~
╰─# bash <(curl -s https://raw.githubusercontent.com/fire1ce/proxmox-vm-disk-expander/main/expand.sh)                                                      1 ↵
      VMID NAME                 STATUS     MEM(MB)    BOOTDISK(GB) PID
       100 vm100                running    4096              40.20 1113
       101 test                 stopped    2048               2.20 0
      9000 ubuntu22-04-cloud    stopped    2048               2.20 0
Enter the VM ID to be expanded: 101
Enter the size to be expanded in GB (exmaple: 10G): 5G
VM ID 101 disk storage1 will be expanded by 5G
Warning: There is no way to downsize the disk!
Are you sure you want to expand the disk? (yes/no): yes

Expanding the disk...  Size of logical volume storage1/vm-101-disk-0 changed from <2.20 GiB (563 extents) to <7.20 GiB (1843 extents).
  Logical volume storage1/vm-101-disk-0 successfully resized.
GPT:Primary header thinks Alt. header is not at the end of the disk.
GPT:Alternate GPT header not at the end of the disk.
GPT: Use GNU Parted to correct GPT errors.
add map storage1-vm--101--disk--0p1 (253:12): 0 4384735 linear 253:11 227328
add map storage1-vm--101--disk--0p14 (253:13): 0 8192 linear 253:11 2048
add map storage1-vm--101--disk--0p15 (253:14): 0 217088 linear 253:11 10240
Warning: The kernel is still using the old partition table.
The new table will be used at the next reboot or after you
run partprobe(8) or kpartx(8)
The operation has completed successfully.
```
