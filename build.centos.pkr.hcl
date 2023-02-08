build {
  sources = [
    "source.nutanix.centos-kickstart"
  ]

  source "nutanix.win2019" {
    name = "win2019"
  }

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
