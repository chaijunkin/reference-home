
variable "access_key" {
  type    = string
  default = "${env("AWS_ACCESS_KEY_ID")}"
}

variable "account_id" {
  type    = string
  default = "${env("AWS_ACCOUNT_ID")}"
}

variable "archive_mirror" {
  type    = string
  default = "archive.ubuntu.com"
}

variable "aws_cfn_bootstrap_version" {
  type    = string
  default = "${env("AWS_CFN_BOOTSTRAP_VERSION")}"
}

variable "awscli_version" {
  type    = string
  default = "${env("AWSCLI_VERSION")}"
}

variable "build_number" {
  type    = string
  default = "${env("BUILD_NUMBER")}"
}

variable "chef_client" {
  type    = string
  default = "false"
}

variable "chef_client_version" {
  type    = string
  default = "${env("CHEF_CLIENT_VERSION")}"
}

variable "cloud_init" {
  type    = string
  default = "true"
}

variable "debug" {
  type    = string
  default = "${env("PACKER_DEBUG")}"
}

variable "description" {
  type    = string
  default = "Ubuntu 20.04 x86_64 (amd64)"
}

variable "ec2_ami_tools_version" {
  type    = string
  default = "${env("EC2_AMI_TOOLS_VERSION")}"
}

variable "ena_driver_version" {
  type    = string
  default = "${env("ENA_DRIVER_VERSION")}"
}

variable "ena_support" {
  type    = string
  default = "false"
}

variable "encrypt_boot" {
  type    = string
  default = "false"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "instance_type" {
  type    = string
  default = "m3.medium"
}

variable "iso_file_name" {
  type    = string
  default = ""
}

variable "itamae" {
  type    = string
  default = "false"
}

variable "itamae_version" {
  type    = string
  default = "${env("ITAMAE_VERSION")}"
}

variable "name" {
  type    = string
  default = "ubuntu-20.04-amd64"
}

variable "network_adapter_model" {
  type    = string
  default = "virtio"
}

variable "proxmox_host" {
  type    = string
  default = "${env("PROXMOX_HOST")}"
}

variable "proxmox_node" {
  type    = string
  default = "${env("PROXMOX_NODE")}"
}

variable "proxmox_password" {
  type    = string
  default = "${env("PROXMOX_PASSWORD")}"
}

variable "proxmox_realm" {
  type    = string
  default = "${env("PROXMOX_REALM")}"
}

variable "proxmox_username" {
  type    = string
  default = "${env("PROXMOX_USERNAME")}"
}

variable "region" {
  type    = string
  default = "${env("AWS_DEFAULT_REGION")}"
}

variable "releases_mirror" {
  type    = string
  default = "releases.ubuntu.com"
}

variable "ruby" {
  type    = string
  default = "false"
}

variable "ruby_version" {
  type    = string
  default = "${env("RUBY_VERSION")}"
}

variable "s3_bucket" {
  type    = string
  default = "${env("S3_BUCKET")}"
}

variable "secret_key" {
  type    = string
  default = "${env("AWS_SECRET_ACCESS_KEY")}"
}

variable "security_group_id" {
  type    = string
  default = "${env("AWS_SECURITY_GROUP_ID")}"
}

variable "source_ami" {
  type    = string
  default = "${env("EC2_SOURCE_AMI")}"
}

variable "spot_price" {
  type    = string
  default = "auto"
}

variable "sriov_driver_version" {
  type    = string
  default = "${env("SRIOV_DRIVER_VERSION")}"
}

variable "sriov_support" {
  type    = string
  default = "false"
}

variable "storage_pool" {
  type    = string
  default = ""
}

variable "storage_pool_type" {
  type    = string
  default = ""
}

variable "subnet_id" {
  type    = string
  default = "${env("EC2_SUBNET_ID")}"
}

variable "token" {
  type    = string
  default = "${env("AWS_SESSION_TOKEN")}"
}

variable "version" {
  type    = string
  default = "0.1.0"
}

variable "virtual_machine_id" {
  type    = string
  default = "900"
}

variable "vpc_id" {
  type    = string
  default = "${env("EC2_VPC_ID")}"
}

variable "x509_cert_path" {
  type    = string
  default = "${env("EC2_CERT")}"
}

variable "x509_key_path" {
  type    = string
  default = "${env("EC2_PRIVATE_KEY")}"
}

variable "zfs" {
  type    = string
  default = "false"
}

source "proxmox" "ubuntu_template" {
  boot_command = ["<esc><wait>", "<esc><wait>", "<enter><wait>", "/install/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " domain=localdomain<wait>", " hostname=localhost<wait>", " apt-setup/security_host=${var.archive_mirror}<wait>", " mirror/http/hostname=${var.archive_mirror}<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/proxmox/ubuntu-20.04/preseed.cfg<wait>", " -- <wait>", "<enter><wait>"]
  boot_wait    = "10s"
  cloud_init   = "${var.cloud_init}"
  cores        = 2
  cpu_type     = "host"
  disks {
    disk_size         = "40G"
    format            = "raw"
    storage_pool      = "${var.storage_pool}"
    storage_pool_type = "${var.storage_pool_type}"
    type              = "scsi"
  }
  http_directory           = "http"
  insecure_skip_tls_verify = true
  iso_file                 = "local:iso/${var.iso_file_name}"
  memory                   = 1024
  network_adapters {
    bridge = "vmbr0"
    model  = "${var.network_adapter_model}"
  }
  node                   = "${var.proxmox_node}"
  os                     = "l26"
  password               = "${var.proxmox_password}"
  proxmox_url            = "https://${var.proxmox_host}:8006/api2/json"
  qemu_agent             = true
  scsi_controller        = "virtio-scsi-pci"
  sockets                = 1
  ssh_handshake_attempts = 30
  ssh_password           = "ubuntu"
  ssh_port               = 22
  ssh_timeout            = "3600s"
  ssh_username           = "ubuntu"
  template_description   = "${var.description}"
  template_name          = "${var.name}"
  unmount_iso            = true
  username               = "${var.proxmox_username}@${var.proxmox_realm}"
  vm_id                  = "${var.virtual_machine_id}"
  vm_name                = "packer-${var.name}"
}

build {
  description = "{{user `description`}}"

  sources = ["source.proxmox.ubuntu_template"]

  provisioner "shell" {
    inline       = ["true"]
    only         = ["proxmox"]
    pause_before = "30s"
  }

  provisioner "file" {
    destination = "/var/tmp"
    source      = "scripts/helpers"
  }

  provisioner "file" {
    destination = "/var/tmp"
    source      = "files/common"
  }

  provisioner "file" {
    destination = "/var/tmp"
    source      = "files/openssl"
  }

  provisioner "file" {
    destination = "/var/tmp"
    source      = "files/zfs"
  }

  provisioner "file" {
    destination = "/var/tmp"
    source      = "files/ruby"
  }

  provisioner "file" {
    destination = "/var/tmp"
    source      = "files/chef"
  }

  provisioner "shell" {
    environment_vars  = ["ARCHIVE_MIRROR=http://${var.archive_mirror}/ubuntu", "BUILD_NUMBER=${var.build_number}", "PACKER_BUILD_NAME=${var.name}", "PACKER_BUILD_TIMESTAMP=${local.timestamp}", "PACKER_BUILD_VERSION=${var.version}", "RUBY_VERSION=${var.ruby_version}", "ITAMAE_VERSION=${var.itamae_version}", "CHEF_CLIENT_VERSION=${var.chef_client_version}"]
    execute_command   = "echo 'ubuntu' | {{ .Vars }} sudo -H -S -E bash  '{{ .Path }}'"
    expect_disconnect = "true"
    only              = ["proxmox"]
    scripts           = ["scripts/proxmox/hostname.sh", "scripts/common/update.sh", "scripts/common/packages.sh", "scripts/common/openssl.sh", "scripts/common/sshd.sh", "scripts/proxmox/motd.sh", "scripts/common/motd.sh", "scripts/common/reboot.sh", "scripts/proxmox/ubuntu.sh", "scripts/common/disable-ipv6.sh", "scripts/common/networking.sh", "scripts/common/python-pip.sh", "scripts/common/dummy.sh", "scripts/common/dummy.sh", "scripts/common/dummy.sh", "scripts/common/dummy.sh", "scripts/common/sudoers.sh", "scripts/proxmox/grub.sh", "scripts/common/clean-up.sh"]
  }

  post-processor "vagrant" {
    keep_input_artifact  = false
    compression_level    = 9
    except               = ["amazon-ebs", "amazon-instance", "proxmox"]
    output               = "images/vagrant-<no value>/${var.name}.box"
    vagrantfile_template = "templates/Vagrantfile.template"
  }
}
