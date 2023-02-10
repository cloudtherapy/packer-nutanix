packer {
  required_plugins {
    nutanix = {
      version = ">= 0.1.0"
      source  = "github.com/nutanix-cloud-native/nutanix"
    }
  }
}

variable "nutanix_username" {
  type = string
}

variable "nutanix_password" {
  type      = string
  sensitive = true
}

variable "nutanix_endpoint" {
  type = string
}

variable "nutanix_port" {
  type = number
}

variable "nutanix_insecure" {
  type    = bool
  default = true
}

variable "nutanix_subnet" {
  type = string
}

variable "nutanix_cluster" {
  type = string
}

variable "centos_iso_image_name" {
  type = string
}


source "nutanix" "centos-kickstart" {
  nutanix_username = var.nutanix_username
  nutanix_password = var.nutanix_password
  nutanix_endpoint = var.nutanix_endpoint
  nutanix_port     = var.nutanix_port
  nutanix_insecure = var.nutanix_insecure
  cluster_name     = var.nutanix_cluster
  os_type          = "Linux"


  vm_disks {
    image_type        = "ISO_IMAGE"
    source_image_name = var.centos_iso_image_name
  }

  vm_disks {
    image_type   = "DISK"
    disk_size_gb = 40
  }

  vm_nics {
    subnet_name = var.nutanix_subnet
  }

  cd_files = ["../scripts/centos7/ks.cfg"]
  cd_label = "OEMDRV"

  image_name       = "centos7-{{isotime `Jan-_2-15:04:05`}}"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  shutdown_timeout = "2m"
  ssh_password     = "packer"
  ssh_username     = "packer"
}

build {
  name = "centos7"
  source "nutanix.centos-kickstart" {}
}