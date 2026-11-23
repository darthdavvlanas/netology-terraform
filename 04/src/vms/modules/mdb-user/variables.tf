variable "cluster_id" {
  type        = string
  description = "MySQL cluster id"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_users" {
  type = list(object({
    name  = string
    roles = list(string)
  }))
  default     = []
  description = "List of MySQL users to create"
}