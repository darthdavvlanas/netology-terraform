terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.16.0"
}

provider "yandex" {
  service_account_key_file  = pathexpand("~/authorized_key-ru.json")
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
}