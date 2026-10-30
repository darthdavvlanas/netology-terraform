#VM vars

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "VM platform type"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "scheduling_policy for VM"
}

variable "vm_web_nat" {
  type        = bool
  default     = false
  description = "NAT for VM"
}

#VM db
variable "vm_db_zone" {
  type        = string
  default     = "kz1-a"
  description = "VM location"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "VM platform type"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "scheduling_policy for VM"
}

variable "vm_db_nat" {
  type        = bool
  default     = false
  description = "NAT for VM"
}
