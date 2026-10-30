data "yandex_compute_image" "fedora43" {
  family    = "fedora-43-custom"
  folder_id = var.folder_id
}
