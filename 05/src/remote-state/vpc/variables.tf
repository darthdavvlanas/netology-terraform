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
