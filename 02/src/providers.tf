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
  cloud_id                  = var.cloud_id_ru
  folder_id                 = var.folder_id_ru
  zone                      = var.default_zone_ru
}


provider "yandex" {
  alias                     = "kz"
  service_account_key_file  = pathexpand("~/authorized_key-kz.json")
  cloud_id                  = var.cloud_id_kz
  folder_id                 = var.folder_id_kz
  zone                      = var.default_zone_kz
  endpoint                  = "api.yandexcloud.kz:443"
}