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

#Environment vars
variable "env_name" {
  type        = string
  default     = "develop"
  description = "Environment name"
}


variable "user" {
  type        = string
  description = "User name for ssh connection"
}


variable "ssh_keys" {
  type        = string
  default     = "~/.ssh/k.guskov.pub"
  sensitive   = true
  description = "Public keys for ssh connection"
}
