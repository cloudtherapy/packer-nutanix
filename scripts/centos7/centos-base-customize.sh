#!/bin/bash -e

main() {
  log "yum install epel-release"
  sudo yum -y install epel-release --nogpgcheck
  log "yum update"
  sudo yum -y update
  log "yum install ansible"
  sudo yum -y install ansible  --nogpgcheck
  log "ansible version"
  ansible --version
  log "run ansible playbook"
  ansible-playbook /tmp/ansible-centos-image.yml
  log "remove ansible playbook"
  rm /tmp/ansible-centos-image.yml
}

log() {
  echo
  echo "[[ ${1} ]]"
  echo
}

main
