locals {
  ssh_key       = file("~/.ssh/k.guskov.pub")
  storage_list  = [yandex_compute_instance.storage]
  dbs           = values(yandex_compute_instance.database)

vpc             = {
  "network_id" = "enp7i560tb28nageq0cc"
  "subnet_ids" = [
    "e9b0le401619ngf4h68n",
    "e2lbar6u8b2ftd7f5hia",
    "b0ca48coorjjq93u36pl",
    "fl8ner8rjsio6rcpcf0h",
  ]
  "subnet_zones" = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c",
    "ru-central1-d",
  ]
}
}
