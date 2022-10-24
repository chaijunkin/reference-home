variable "proxmox_user" {
  type        = string
  description = "proxmox username"
  default     = "root@pam"
}
variable "proxmox_pass" {
  type        = string
  description = "proxmox password"
  default     = "junkin2021pmx"
}
variable "proxmox_iso_file" {
  type        = string
  description = "iso file on local storage, for example local:iso/ubuntu-20.04.3-live-server-amd64.iso"
  default = "local:iso/ubuntu-20.04.5-live-server-amd64.iso"
}
# variable "proxmox_iso_checksum" {
#   type        = string
#   description = "check sum of the iso from above"
# }
variable "proxmox_host" {
  type        = string
  description = "hostname or ip for the proxmox host"
  default = "192.168.1.7"
}
variable "proxmox_node" {
  type        = string
  description = "proxmox node name"
  default = "dashy"
}
variable "proxmox_vm_id" {
  type        = string
  description = "vm id to use when creating the vm and template"
  default = "10001"
}
variable "proxmox_template_name" {
  type        = string
  description = "name of the vm template at the end of theday"
  default     = "ubuntu-20.04-packer-vm"
}
variable "proxmox_template_description" {
  type        = string
  description = "name of the vm template at the end of theday"
  default     = "packer-vm"
}
variable "proxmox_storage_pool" {
  type        = string
  description = "storage pool on the proxmox node"
  default     = "local-lvm"
}
variable "ssh_username" {
  type        = string
  description = "ssh username"
  default     = "ubuntu"
}
variable "ssh_password" {
  type        = string
  description = "ssh password"
  default     = "ubuntu"
}
variable "http_directory" {
  type        = string
  description = "the http directory to serve up for the cloud-init files"
  default     = "http"
}