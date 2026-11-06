###cloud vars

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

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

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "each_vm" {
  type            = list(object({
    vm_name       = string
    vm_platform   = string
    update_policy = bool
    cpu           = number
    cpu_fraction  = number
    ram           = number
    disk_volume   = number
    disk_type     = string
    nat           = bool
    preemptible   = bool
  }))
  description     = "Define VMs config"
  default         = [
    {
      vm_name       = "main"
      vm_platform   = "standard-v3"
      update_policy = true
      cpu           = 4
      cpu_fraction  = 20
      ram           = 4
      disk_volume   = 10
      disk_type     = "network-hdd"
      nat           = true
      preemptible   = true
    },
    {
      vm_name       = "replica"
      vm_platform   = "standard-v3"
      update_policy = true
      cpu           = 2
      cpu_fraction  = 20
      ram           = 2
      disk_type     = "network-hdd"
      disk_volume   = 10
      nat           = true
      preemptible   = true
    }
  ]
}

variable "user" {
  type        = string
  description = "ssh user"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2404-lts"
  description = "OS family for get image id"
}
