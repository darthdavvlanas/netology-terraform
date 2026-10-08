variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "subnet" {
  type = string
}

variable "user" {
  type        = string
  description = "ssh user"
}
