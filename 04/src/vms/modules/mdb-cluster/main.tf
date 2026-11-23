resource "yandex_mdb_mysql_cluster" "cluster" {
  name                = var.cluster_name
  environment         = var.environment
  network_id          = var.network_id
  version             = var.mysql_version
  security_group_ids  = var.security_group_ids
  deletion_protection = var.deletion_protection

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  dynamic "host" {
    for_each = local.mysql_hosts
    content {
      zone             = host.value.zone
      subnet_id        = host.value.subnet_id
      assign_public_ip = var.assign_public_ip
      priority         = var.priority
      backup_priority  = var.backup_priority
    }
  }
}
