# proxmox-disk-expander
Expand your VM disks (including the partition) from your Proxmox host with a single command

## Usage

### Expand VM (with id 100) disk by 15G by downloading script

#### Using curl 
```bash
curl -fsSL https://raw.githubusercontent.com/bermanboris/proxmox-disk-expander/main/expand.sh | bash -s -- 100 5G
```


#### Using locally
```bash
curl -sO https://raw.githubusercontent.com/bermanboris/proxmox-disk-expander/main/expand.sh
bash expand.sh 100 15G
```
