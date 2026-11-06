resource "yandex_compute_instance" web {
  depends_on                = [yandex_compute_instance.database]
  count                     = 2
  name                      = "web-${count.index + 1}"
  hostname                  = "web-${count.index + 1}"
  description               = "Web server ${count.index + 1}"
  zone                      = var.default_zone_kz
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

    resources {
        cores                   = 2
        core_fraction           = 20
        memory                  = 2
    }

    boot_disk {
        initialize_params {
            image_id            = data.yandex_compute_image.ubuntu.id
            size                = 10
            type                = "network-hdd"
        }
    }

    network_interface {
      subnet_id          = yandex_vpc_subnet.develop.id
      security_group_ids = [yandex_vpc_security_group.example.id]
      nat                = true
    }

    scheduling_policy {
      preemptible = true
    }

    metadata = {
      user-data = templatefile("${path.module}/linux.tpl", {
        username   = var.user
        ssh_public = local.ssh_key
      })
    }
}

