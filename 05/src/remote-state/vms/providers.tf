terraform {
  
  backend "s3" {
    profile = "netology"
    bucket  = "netology-bucket-0038xfhpjx6ok6ro"
    key     = "netology/develop/vms/terraform.tfstate"
    region  = "ru-central1"
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.250.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }
  required_version = "~>1.16.0"
}

provider "yandex" {
  service_account_key_file  = pathexpand("~/authorized_key-ru.json")
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
}