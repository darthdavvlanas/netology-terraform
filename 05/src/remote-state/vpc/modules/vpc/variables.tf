variable "env_name" {
  type        = string
  description = "Environment name"
}

variable "subnets_v4" {
  type      = list(object({
    zone    = string
    cidr    = list(string)
  }))
  description = "List subnets in zones"
}
