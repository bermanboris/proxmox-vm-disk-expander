# proxmox-vm-disk-expander

Interactive disk expander for Proxmox VE.
Expand your VM disks (including the partition) from your Proxmox host.

## Usage

### Curl method:

It will run the script once without installing it.

```bash
bash <(curl -s https://raw.githubusercontent.com/fire1ce/proxmox-vm-disk-expander/main/expand.sh)
```

### Installer

It will install the script at Proxmox host for multiple use.

Run the following command from Proxmox host:

```bash
curl -sO https://raw.githubusercontent.com/bermanboris/proxmox-disk-expander/main/expand.sh
bash expand.sh 100 15G
```
