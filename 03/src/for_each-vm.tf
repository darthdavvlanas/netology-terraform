resource "yandex_compute_instance" "database" {
    for_each = { for vm in var.each_vm : vm.vm_name => vm }

    name                        = each.key
    hostname                    = each.key
    description                 = "Database VM ${each.key}"
    platform_id                 = each.value.vm_platform
    allow_stopping_for_update   = each.value.update_policy

    resources {
        cores           = each.value.cpu
        core_fraction  = each.value.cpu_fraction
        memory          = each.value.ram
    }

    boot_disk {
        initialize_params {
          image_id        = data.yandex_compute_image.ubuntu.id
          size            = each.value.disk_volume
          type            = each.value.disk_type
        }
    }

    network_interface {
        subnet_id           = yandex_vpc_subnet.develop.id
        security_group_ids  = [yandex_vpc_security_group.example.id]
        nat                 = each.value.nat
    }

    scheduling_policy {
        preemptible   = each.value.preemptible
    }

    metadata = {
      user-data = templatefile("${path.module}/linux.tpl", {
        username   = var.user
        ssh_public = local.ssh_key
      })
    }
}
