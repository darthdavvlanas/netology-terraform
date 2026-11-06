output "vms" {
  value       = [
    for vm in concat(yandex_compute_instance.web[*],local.dbs,[yandex_compute_instance.storage]) : {
        name    = vm.name
        id      = vm.id
        FQDN    = vm.fqdn
    }

    ]
  description = "description"

}
