locals {
  ssh_key       = file("~/.ssh/k.guskov.pub")
  storage_list  = [yandex_compute_instance.storage]
  dbs           = values(yandex_compute_instance.database)
}
