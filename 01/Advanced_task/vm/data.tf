data "yandex_compute_image" "fedora43_docker" {
  family    = "fedora-43-custom"
  folder_id = var.folder_id
}
