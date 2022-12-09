build {
  sources = [
    "source.nutanix.centos-kickstart"
  ]
  
  provisioner "shell" {
    only = ["nutanix.centos-kickstart"]
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo \"FOO is $FOO\" > example2.txt",
    ]
  }
}
