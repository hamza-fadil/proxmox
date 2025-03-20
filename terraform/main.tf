terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.65.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_host
  api_token = var.proxmox_password
  insecure  = true  # Set to false if using valid SSL certs
}

# Master Node
resource "proxmox_virtual_environment_vm" "k8s-master" {
  count     = 1
  name      = "k8s-master-${count.index + 1}"
  node_name = "pve"

  clone {
    vm_id = 100  # Change this to your Debian 12 template ID
    full  = true
  }

  cpu {
    cores = 2  # 2 vCPUs
  }

  memory {
    dedicated = 8192  # 8 GB RAM for the master node
  }

  disk {
    datastore_id = "hdd"
    interface = "scsi0"
    size = "32"
  }


  agent {
    enabled = true
  }
}

# Worker Nodes
resource "proxmox_virtual_environment_vm" "k8s-worker" {
  count     = 2
  name      = "k8s-worker-${count.index + 1}"
  node_name = "pve"

  clone {
    vm_id = 100  # Change this to your Debian 12 template ID
    full  = true
  }

  cpu {
    cores = 2  # 2 vCPUs for each worker node
  }

  memory {
    dedicated = 11264  # 11 GB RAM for each worker node
  }

  disk {
    datastore_id = "hdd"
    interface = "scsi0"
    size = "32"
  }

  agent {
    enabled = true
  }
}
