###cloud vars
variable "cloud_id" {
  type        = string
  sensitive   = true
  description = "Cloud id"
}

variable "folder_id" {
  type        = string
  sensitive   = true
  description = "Folder id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default zone for deploy"
}
