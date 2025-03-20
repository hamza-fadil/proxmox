variable "proxmox_host" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox API password"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Proxmox node where VMs will be created"
  type        = string
}
