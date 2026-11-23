variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "environment" {
  type        = string
  default     = "PRESTABLE"
  description = "Environment name"
}

variable "mysql_version" {
  type        = string
  default     = "8.4"
  description = "MySQL version"
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "Protect cluster from delete"
}

variable "resource_preset_id" {
  type        = string
  default     = "b2.medium"
  description = "Host class"
}

variable "disk_type_id" {
  type        = string
  default     = "network-hdd"
  description = "Disk type"
}

variable "disk_size" {
  type        = number
  default     = 10
  description = "description"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "List security groups ids"
}

variable "assign_public_ip" {
  type        = bool
  default     = true
  description = "Public access to host true or false"
}

variable "priority" {
  type        = number
  default     = 0
  description = "Priority for selecting a new master host: from 0 to 100"
}

variable "backup_priority" {
  type        = number
  default     = 0
  description = "Priority for backup: from 0 to 100."
}

variable "HA" {
  type        = bool
  default     = false
  description = "Enable High Availability (2 hosts)"
}

variable "host_count" {
  type        = number
  default     = 2
  description = "Number of mysql hosts"
}

variable "network_id" {
  type          = string
  description   = "Network ID"
}

variable "subnet_ids" {
  type          = map(string)
  description   = "Sunets IDs"
}

variable "subnet_zones" {
  type          = map(string)
  description   = "Subnets zones"
}
