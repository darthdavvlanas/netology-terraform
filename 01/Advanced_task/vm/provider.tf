provider "yandex" {
  service_account_key_file  = pathexpand("~/authorized_key-ru.json")
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
  zone                      = var.zone
  # endpoint                  = "api.yandexcloud.kz:443"
  # storage_endpoint          = "https://storage.yandexcloud.kz"
}
