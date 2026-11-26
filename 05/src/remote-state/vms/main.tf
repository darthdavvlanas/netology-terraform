# Create security groups
resource "yandex_vpc_security_group" "web" {
  name       = "example_dynamic"
  network_id = data.terraform_remote_state.vpc.outputs.network_id
  folder_id  = var.folder_id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      protocol       = lookup(ingress.value, "protocol", null)
      description    = lookup(ingress.value, "description", null)
      port           = lookup(ingress.value, "port", null)
      from_port      = lookup(ingress.value, "from_port", null)
      to_port        = lookup(ingress.value, "to_port", null)
      v4_cidr_blocks = lookup(ingress.value, "v4_cidr_blocks", null)
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      protocol       = lookup(egress.value, "protocol", null)
      description    = lookup(egress.value, "description", null)
      port           = lookup(egress.value, "port", null)
      from_port      = lookup(egress.value, "from_port", null)
      to_port        = lookup(egress.value, "to_port", null)
      v4_cidr_blocks = lookup(egress.value, "v4_cidr_blocks", null)
    }
  }
}

#Create marketing web
module "marketing" {
  source              = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=0f41ce711a18cd1a0cb037f21ab3c4acc9257c88"
  env_name            = var.env_name
  network_id          = data.terraform_remote_state.vpc.outputs.network_id
  subnet_zones        = ["ru-central1-a"]
  subnet_ids          = [data.terraform_remote_state.vpc.outputs.subnet_ids["ru-central1-a"]]
  security_group_ids  = [yandex_vpc_security_group.id]
  instance_name       = "web-marketing"
  instance_count      = 1
  image_family        = "ubuntu-2404-lts"
  public_ip           = false

  labels = { 
    project = "marketing"
     }

  metadata = {
    user-data           = data.template_file.cloudinit.rendered
    serial-port-enable  = 1
  }

}

#Create analytics web
module "analytics" {
  source              = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=0f41ce711a18cd1a0cb037f21ab3c4acc9257c88"
  env_name            = var.env_name
  network_id          = data.terraform_remote_state.vpc.outputs.network_id
  subnet_zones        = ["ru-central1-a"]
  subnet_ids          = [data.terraform_remote_state.vpc.outputs.subnet_ids["ru-central1-a"]]
  security_group_ids  = [yandex_vpc_security_group.id]
  instance_name       = "web-analytics"
  instance_count      = 1
  image_family        = "ubuntu-2404-lts"
  public_ip           = false

  labels = {
    project = "analytics"
     }

  metadata = {
    user-data           = data.template_file.cloudinit.rendered
    serial-port-enable  = 1
  }

}
