#Create VPC
resource "yandex_vpc_network" "vpc" {
  name = var.env_name
}

#Create subnet
resource "yandex_vpc_subnet" "subnet" {
  for_each = { for subnet in var.subnets_v4 : subnet.zone => subnet }
  
  name           = "${var.env_name}-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = each.value.cidr
}
