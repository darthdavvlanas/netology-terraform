data "yandex_compute_image" "ubuntu" {
  provider              = yandex.kz
  family                = var.image_family
}