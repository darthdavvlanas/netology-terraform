data "yandex_compute_image" "centos9_docker" {
  family    = "centos-9-custom"
  folder_id = var.folder_id
}
