# Host info
proxmox_url             = "https://192.168.1.7:8006/api2/json"
proxmox_node            = "dashy"
storage_pool            = "local-lvm"
storage_pool_type       = "lvm"
proxmox_username        = "root@pam"
proxmox_password        = "junkin2021pmx"


# VM Info Ubuntu:
http_directory  = "http"
os_version      = "20.04"
os_family       = "ubuntu"
guest_os_type   = "ubuntu64Guest"
cdrom_type      = "sata"
iso_file        = "local:iso/ubuntu-20.04.5-live-server-amd64.iso"
ssh_username    = "ubuntu"
ssh_key         = "/home/vagrant/.ssh/jk_inventory"
boot_command = [
    "<esc><wait><esc><wait><f6><wait><esc><wait>",
    "<bs><bs><bs><bs><bs>",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "-- <enter>"
]

# Vm Info
disk_size               = "15G"
type                    = "scsi"
memory                  = 4096
vm_cores                = 1
network-bridge          = "vmbr0"

# Timeouts:
ip_wait                 = "20m"
ssh_timeout             = "40m"
ssh_port                = "22"
ssh_handshakes          = "40"
shutdown_timeout        = "15m"
ssh_handshake_attempts  = "100"
boot_wait               = "3s"