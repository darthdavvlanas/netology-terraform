output "network_name" {
  value       = yandex_vpc_network.vpc.name
  description = "VPC name"
}

output "subnet_name" {
  value       = { for k, v in yandex_vpc_subnet.subnet : k => v.name }
  description = "Map of subnet names"
}

output "v4_cidr_blocks" {
  value       = { for k, v in yandex_vpc_subnet.subnet : k => v.v4_cidr_blocks }
  description = "Map of CIDR blocks for subnets"
}

output "subnet_id" {
  value       = { for k, s in yandex_vpc_subnet.subnet : k => s.id }
  description = "Map of subnet IDs"
}

output "network_id" {
  value       = yandex_vpc_network.vpc.id
  description = "Network ID for root module usage"
}

output "subnet_zones" {
  value       = { for k, subnet in yandex_vpc_subnet.subnet : k => subnet.zone }
  description = "Map of subnet zones"
}
