# Generate subnet name
locals {
  subnet_names = { for subnet in var.subnets_v4 : subnet.zone => "${var.env_name}-${subnet.zone}" }
}
