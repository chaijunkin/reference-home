variable "proxmox_user" {
  type        = string
  description = "proxmox username"
  default     = "packer@pam!<api-tag>"
}
variable "proxmox_pass" {
  type        = string
  description = "proxmox password"
  default     = "packer"
}
variable "proxmox_iso_file" {
  type        = string
  description = "iso file on local storage, for example local:iso/ubuntu-20.04.3-live-server-amd64.iso"
}
variable "proxmox_iso_checksum" {
  type        = string
  description = "check sum of the iso from above"
}
variable "proxmox_host" {
  type        = string
  description = "hostname or ip for the proxmox host"
}
variable "proxmox_node" {
  type        = string
  description = "proxmox node name"
}
variable "proxmox_vm_id" {
  type        = string
  description = "vm id to use when creating the vm and template"
}
variable "proxmox_template_name" {
  type        = string
  description = "name of the vm template at the end of theday"
  default     = "packer-vm"
}
variable "proxmox_template_description" {
  type        = string
  description = "name of the vm template at the end of theday"
  default     = "packer-vm"
}
variable "proxmox_storage_pool" {
  type        = string
  description = "storage pool on the proxmox node"
}
variable "ssh_username" {
  type        = string
  description = "ssh username"
  default     = "packer"
}
variable "ssh_password" {
  type        = string
  description = "ssh password"
  default     = "packer"
}
variable "http_directory" {
  type        = string
  description = "the http directory to serve up for the cloud-init files"
  default     = "http"
}