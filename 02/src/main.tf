resource "yandex_vpc_network" "develop" {
  provider              = yandex.kz
  name                  = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  provider              = yandex.kz
  name                  = var.vpc_name
  zone                  = var.default_zone_kz
  network_id            = yandex_vpc_network.develop.id
  v4_cidr_blocks        = var.default_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "develop_gateway" {
  provider              = yandex.kz
  folder_id             = var.folder_id_kz
  name                  = "develop-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  provider              = yandex.kz
  folder_id             = var.folder_id_kz
  name                  = "inet-route"
  network_id            = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.develop_gateway.id
  }
}

resource "yandex_compute_instance" "platform" {
  provider              = yandex.kz
  name                  = local.web_name
  hostname              = local.web_name
  platform_id           = var.vm_web_platform_id
  zone                  = var.default_zone_kz
  resources {
    cores               = var.vms_resources.web.cores
    memory              = var.vms_resources.web.memory
    core_fraction       = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id          = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible         = var.vm_web_preemptible
  }
  network_interface {
    subnet_id           = yandex_vpc_subnet.develop.id
    nat                 = var.vm_web_nat
  }

  metadata = {
    serial-port-enable  = var.metadata.connect.serial-port-enable
    ssh-keys            = var.metadata.connect.ssh-keys
  }

}

resource "yandex_compute_instance" "database" {
  provider              = yandex.kz
  name                  = local.db_name
  hostname              = local.db_name
  zone                  = var.vm_db_zone
  platform_id           = var.vm_db_platform_id
  resources {
    cores               = var.vms_resources.db.cores
    memory              = var.vms_resources.db.memory
    core_fraction       = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id          = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible         = var.vm_db_preemptible
  }
  network_interface {
    subnet_id           = yandex_vpc_subnet.develop.id
    nat                 = var.vm_db_nat
  }

  metadata = {
    serial-port-enable  = var.metadata.connect.serial-port-enable
    ssh-keys            = var.metadata.connect.ssh-keys
  }

}
