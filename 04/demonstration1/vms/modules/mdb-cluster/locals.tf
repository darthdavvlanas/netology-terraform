locals {
  final_host_count = var.HA ? var.host_count : 1
  
  subnet_keys = keys(var.subnet_ids)
  
  mysql_hosts = [
    for i in range(local.final_host_count) : {
      zone      = var.subnet_zones[element(local.subnet_keys, i)]
      subnet_id = var.subnet_ids[element(local.subnet_keys, i)]
    }
  ]
}