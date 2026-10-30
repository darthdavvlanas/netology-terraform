output "vms" {
  description       = "Информация о ВМ: instance_name, external_ip, fqdn"

  value = {
    for key, vm in {
      platform      = yandex_compute_instance.platform
      database      = yandex_compute_instance.database
    } : key => {
      instance_name = vm.name
      external_ip   = try(vm.network_interface[0].nat_ip_address, null)
      fqdn          = vm.fqdn
    }
  }
}
