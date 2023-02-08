packer {
  required_plugins {
    nutanix = {
      version = ">= 0.1.0"
      source  = "github.com/nutanix-cloud-native/nutanix"
    }
  }
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

  cd_files = ["scripts/ks.cfg"]
  cd_label = "OEMDRV"

  image_name       = "centos7-{{isotime `Jan-_2-15:04:05`}}"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  shutdown_timeout = "2m"
  ssh_password     = "packer"
  ssh_username     = "packer"
}

source "nutanix" "win2019" {
  nutanix_username = var.nutanix_username
  nutanix_password = var.nutanix_password
  nutanix_endpoint = var.nutanix_endpoint
  nutanix_insecure = var.nutanix_insecure
  cluster_name     = var.nutanix_cluster

  vm_disks {
    image_type        = "ISO_IMAGE"
    source_image_name = var.windows_2019_iso_image_name
  }

  vm_disks {
    image_type        = "ISO_IMAGE"
    source_image_name = var.virtio_iso_image_name
  }

  vm_disks {
    image_type   = "DISK"
    disk_size_gb = 80
  }

  vm_nics {
    subnet_name = var.nutanix_subnet
  }

  cd_files = ["scripts/autounattend.xml", "scripts/configure-ansible.ps1", "scripts/deploy-bginfo.ps1", "scripts/enable-winrm.ps1", "scripts/install-chocolatey.ps1"]

  image_name       = "win2019-{{isotime `Jan-_2-15:04:05`}}"
  shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "5m"
  cpu              = 2
  os_type          = "Windows"
  memory_mb        = "8192"
  communicator     = "winrm"
  winrm_insecure   = "true"
  winrm_use_ssl    = "true"
  winrm_timeout    = "10m"
  winrm_password   = var.windows_password
  winrm_username   = "Administrator"
}