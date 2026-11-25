data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    profile                     = "netology"
    bucket                      = "netology-bucket-0038xfhpjx6ok6ro"
    key                         = "netology/develop/vpc/terraform.tfstate"
    region                      = "ru-central1"
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

data "template_file" "cloudinit" {
  template  = file("./cloud-init.yml")
  
  vars = {
    user     = var.user
    ssh_keys = file("~/.ssh/k.guskov.pub")
  }
}