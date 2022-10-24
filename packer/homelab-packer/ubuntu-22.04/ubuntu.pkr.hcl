packer {
  required_plugins {
    proxmox = {
      version = " >= 1.0.1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "proxmox-ubuntu-20" {
  proxmox_url = "https://${var.proxmox_host}:8006/api2/json"
  vm_name     = "${var.proxmox_template_name}"
  vm_id       = "${var.proxmox_vm_id}"
  iso_file     = "${var.proxmox_iso_file}"
  iso_checksum = "${var.proxmox_iso_checksum}"
  username         = "${var.proxmox_user}"
  password         = "${var.proxmox_pass}"
  node             = "${var.proxmox_node}"

  ssh_username           = "${var.ssh_username}"
  ssh_password           = "${var.ssh_password}"
  ssh_timeout            = "24h"
  ssh_pty                = true
  ssh_handshake_attempts = 20

  boot_wait      = "6s"
  http_directory = "${var.http_directory}"
  boot_command = [
      "c",
      "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ",
      "<enter><wait>",
      "initrd /casper/initrd<enter><wait>",
      "boot<enter>"
    ]
  insecure_skip_tls_verify = true

  template_name        = "${var.proxmox_template_name}"
  template_description = "${var.proxmox_template_description}"
  unmount_iso          = true

  cloud_init = true
  cloud_init_storage_pool = "${var.proxmox_storage_pool}"

  memory     = 4096
  cores      = 2
  sockets    = 1
  scsi_controller = "virtio-scsi-pci"
  os         = "l26"
  qemu_agent = true

  disks {
    type              = "scsi"
    disk_size         = "10G"
    storage_pool      = "${var.proxmox_storage_pool}"
    storage_pool_type = "lvm"
    format            = "raw"
  }
  
  network_adapters {
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = true
  }
}

build {
  sources = ["source.proxmox-iso.proxmox-ubuntu-20"]
  # copy the 99_pve.cfg file to /tmp, to be added to /etc/cloud/cloud.cfg.d/99_pve.cfg
  # as per - https://pve.proxmox.com/wiki/Cloud-Init_FAQ#Creating_a_custom_cloud_image
  provisioner "file" {
    source = "files/99_pve.cfg.txt"
    destination = "/tmp/99_pve.cfg"
  }

  # wait for cloud-init to finish, copy above file to /etc/cloud/cloud.cfg.d
  # prepare the vm for being a template as per https://www.learnlinux.tv/proxmox-ve-full-course-class-6-creating-virtual-machine-templates/
  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 3; done",
      "echo moving files",
      "sudo mv /tmp/99_pve.cfg /etc/cloud/cloud.cfg.d/99_pve.cfg",
      "echo removing host keys",
      "sudo rm /etc/ssh/ssh_host_*",
      "echo machine id",
      "sudo truncate -s 0 /etc/machine-id",
      "echo apt clean",
      "sudo apt clean",
      "echo removing packages",
      "sudo apt autoremove" 
    ]
  }
}