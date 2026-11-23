output "network_id" {
  value = module.vpc_prod.network_id
}

output "subnet_ids" {
  value = module.vpc_prod.subnet_id 
  description = "Map of subnet IDs"
}