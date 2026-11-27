terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    profile = "netology"
    bucket  = "netology-bucket-0038xfhpjx6ok6ro"
    key     = "netology/develop/s3/terraform.tfstate"
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
      version = "> 0.9"
    }

    random = {
      source  = "hashicorp/random"
      version = "> 3.5"
    }
  }
}

provider "yandex" {
  service_account_key_file  = pathexpand("~/authorized_key-ru.json")
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
}

provider "aws" {
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  access_key                  = "fake"
  secret_key                  = "fake"
}