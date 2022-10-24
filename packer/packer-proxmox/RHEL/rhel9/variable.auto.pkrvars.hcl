### Proxmox Node ###
proxmox_node                = "jumpy"
proxmox_url                 = "https://192.168.1.5:8006/api2/json"
proxmox_username            = "root@pam"
proxmox_password            = "junkin2021pmx"

### iso Config ### 
iso_file            = "local:iso/rhel-baseos-9.0-x86_64-boot.iso"
  boot_command      = ["<esc><wait>", "vmlinuz initrd=initrd.img inst.geoloc=0 rd.driver.blacklist=dm-multipath net.ifnames=0 biosdevname=0 ", "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg", "<enter>"]
boot_wait           = "3s"
http_directory      = "http"

### Template ###
################
# VM Config #
cpu         = 2
cpu_type    = "host"
memory      = 10240
#Disks
disk_size               = "30G"
storage_pool            = "local"
storage_pool_type       = "directory"
type                    = "virtio"
format                  = "qcow2"
#Network
bridge                  = "vmbr0"
#Info
template_description    = "Rhel 8.5"
template_name           = "Template-rhel8.5"

#ssh
ssh_handshake_attempts  = "100"
ssh_username            = "username"
ssh_password            = "password"
ssh_timeout             = "40m"
