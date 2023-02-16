#!/bin/bash -e

main() {
  log "Wait 2 minutes"
  sleep 120
  log "Set Variables"
  echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
  log "apt-get -y update" 
  sudo apt-get -y update
  log "apt-get install ansible" 
  sudo apt-get -y install ansible
  log "apt-get -y upgrade" 
  sudo apt-get -y upgrade
  log "apt-get -y autoremove" 
  sudo apt-get -y autoremove
  log "apt-get clean" 
  sudo apt-get clean
  log "ansible version"
  ansible --version
  log "run ansible playbook"
  ansible-playbook /tmp/ansible-ubuntu-image.yml
  log "remove ansible playbook"
  rm /tmp/ansible-ubuntu-image.yml
 ##### Commented out to resolve DHCP issue with VMware clone of a Packer built image
 #Reset the machine-id value. This has known to cause issues with DHCP
 #log "reset machine-id"
 #sudo truncate -s 0 /etc/machine-id
 #sudo rm /var/lib/dbus/machine-id
 #sudo ln -s /etc/machine-id /var/lib/dbus/machine-id
 #log "reset cloud-init"
 #sudo rm /etc/cloud/cloud.cfg.d/*.cfg
 #sudo cloud-init clean -s -l
}

log() {
  echo
  echo "[[ ${1} ]]"
  echo
}

main