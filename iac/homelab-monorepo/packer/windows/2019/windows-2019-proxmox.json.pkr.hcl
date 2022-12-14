
variable "os_iso_filename" {
  type    = string
  default = "local:iso/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
}

variable "proxmox_iso_storage_pool" {
  type    = string
  default = "local"
}

variable "template_name" {
  type    = string
  default = "tpl-win2019-DC"
}

variable "unattend_iso_checksum" {
  type    = string
  default = "c9b5d7ae74de10032b307b508d11f721"
}

variable "virtio_iso_filename" {
  type    = string
  default = "local:iso/virtio-win-0.1.190.iso"
}

variable "virtio_iso_url" {
  type    = string
  default = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.190-1/virtio-win.iso"
}

variable "vm_cores" {
  type    = string
  default = "2"
}

variable "vm_cpu_type" {
  type    = string
  default = "host"
}

variable "vm_disk_format" {
  type    = string
  default = "qcow2"
}

variable "vm_disk_size" {
  type    = string
  default = "50G"
}

variable "vm_disk_type" {
  type    = string
  default = "scsi"
}

variable "vm_enable_qemu_agent" {
  type    = string
  default = "true"
}

variable "vm_hostname" {
  type    = string
  default = "server2019-DC-tpl"
}

variable "vm_memory" {
  type    = string
  default = "2048"
}

variable "vm_network_adapter_bridge" {
  type    = string
  default = "vmbr0"
}

variable "vm_network_adapter_model" {
  type    = string
  default = "virtio"
}

variable "vm_os_type" {
  type    = string
  default = "win10"
}

variable "vm_scsi_controller" {
  type    = string
  default = "virtio-scsi-pci"
}

variable "vm_sockets" {
  type    = string
  default = "2"
}

variable "vm_storage_pool" {
  type    = string
  default = "vm-store"
}

variable "vm_storage_pool_type" {
  type    = string
  default = "directory"
}

variable "winrm_password" {
  type    = string
  default = "packer"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

locals {
  template_description = "Windows Server 2019 Datacenter template generated by Packer on ${legacy_isotime("2006-01-02T15:04:05Z")}."
}

source "proxmox" "autogenerated_1" {
  additional_iso_files {
    device       = "ide0"
    iso_checksum = "none"
    iso_file     = "${var.virtio_iso_filename}"
    unmount      = true
  }
  additional_iso_files {
    device       = "ide1"
    iso_checksum = "none"
    iso_file     = "local:iso/unattend.iso"
    unmount      = true
  }
  cloud_init              = true
  cloud_init_storage_pool = "${var.vm_storage_pool}"
  communicator            = "winrm"
  cores                   = "${var.vm_cores}"
  cpu_type                = "${var.vm_cpu_type}"
  disks {
    disk_size         = "${var.vm_disk_size}"
    format            = "${var.vm_disk_format}"
    storage_pool      = "${var.vm_storage_pool}"
    storage_pool_type = "${var.vm_storage_pool_type}"
    type              = "${var.vm_disk_type}"
  }
  insecure_skip_tls_verify = true
  iso_file                 = "${var.os_iso_filename}"
  memory                   = "${var.vm_memory}"
  network_adapters {
    bridge = "${var.vm_network_adapter_bridge}"
    model  = "${var.vm_network_adapter_model}"
  }
  node                 = "${var.proxmox_node}"
  os                   = "${var.vm_os_type}"
  password             = "${var.proxmox_password}"
  proxmox_url          = "${var.proxmox_api_url}"
  qemu_agent           = "${var.vm_enable_qemu_agent}"
  scsi_controller      = "${var.vm_scsi_controller}"
  sockets              = "${var.vm_sockets}"
  template_description = "${local.template_description}"
  template_name        = "${var.template_name}"
  unmount_iso          = true
  username             = "${var.proxmox_username}"
  winrm_insecure       = true
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "180m"
  winrm_use_ssl        = true
  winrm_username       = "${var.winrm_username}"
}

build {
  description = "Build Windows Server 2019 Proxmox template"

  sources = ["source.proxmox.autogenerated_1"]

  provisioner "file" {
    destination = "C:\\Program Files\\Cloudbase Solutions\\Cloudbase-Init\\conf\\cloudbase-init.conf"
    source      = "windows/2019/cloudbase_init_templates/cloudbase-init.conf"
  }

  provisioner "file" {
    destination = "C:\\Program Files\\Cloudbase Solutions\\Cloudbase-Init\\conf\\cloudbase-init-unattend.conf"
    source      = "windows/2019/cloudbase_init_templates/cloudbase-init-unattend.conf"
  }

  provisioner "windows-shell" {
    inline = ["cd \"C:\\Program Files\\Cloudbase Solutions\\Cloudbase-Init\\conf\"", "c:\\Windows\\System32\\Sysprep\\sysprep.exe /quiet /generalize /oobe /unattend:Unattend.xml"]
  }

}
