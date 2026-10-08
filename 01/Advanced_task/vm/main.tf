resource "yandex_compute_instance" "fedora_docker" {

    name                        = "fedora-docker"
    hostname                    = "fedora-docker"
    folder_id                   = var.folder_id
    zone                        = var.zone
    platform_id                 = "standard-v2"

    allow_stopping_for_update   = true

    resources {
        cores                   = 2
        core_fraction           = 20
        memory                  = 4
    }

    boot_disk {
        initialize_params {
            image_id            = data.yandex_compute_image.fedora43_docker.id
            size                = 25
            type                = "network-hdd"
        }
    }

    network_interface {
        subnet_id               = var.subnet
        nat                     = true
    }

    scheduling_policy {
      preemptible = true
    }

    metadata = {
      user-data = templatefile("${path.module}/linux.tpl", {
        env        = "perf"
        username   = var.user
        ssh_public = file("~/.ssh/k.guskov.pub")
      })
    }
}

resource "null_resource" "create_docker_context" {
  # Wait VM is created
  depends_on = [yandex_compute_instance.fedora_docker]

  # Trigger for recreate context if ip changes
  triggers = {
    vm_ip = yandex_compute_instance.fedora_docker.network_interface[0].nat_ip_address
  }

  # Create dcoker remote context
  provisioner "local-exec" {
    command = <<-EOT
      docker context rm fedora-docker 2>/dev/null || true
      docker context create fedora-docker --docker "host=ssh://${var.user}@${yandex_compute_instance.fedora_docker.network_interface[0].nat_ip_address}"
    EOT
  }
}