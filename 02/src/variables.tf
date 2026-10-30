###cloud vars


variable "cloud_id_kz" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id_kz" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone_kz" {
  type        = string
  default     = "kz1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cloud_id_ru" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id_ru" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone_ru" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS family for get image id"
}

variable "project" {
  type        = string
  default     = "netology"
  description = "Project name"
}

variable "staging" {
  type        = string
  default     = "develop"
  description = "Staging name"
}

variable "product" {
  type        = string
  default     = "platform"
  description = "Product name"
}

variable "vms_resources" {
  type        = map(object({
    cores           = number
    memory          = number
    core_fraction   = number
  }))
  description = "VM cores, memory, core_fraction"
}

variable "metadata" {
  type        = map(object({
    serial-port-enable  = number
    ssh-keys            = string
  }))
  description = "metadata"
}
