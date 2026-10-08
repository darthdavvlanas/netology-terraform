output "fedora_docker_name" {
  description = "Имя VM"
  value       = yandex_compute_instance.fedora_docker.name
}

output "fedora_docker_ip" {
  description = "Внешний IP VM"
  value       = yandex_compute_instance.fedora_docker.network_interface[0].nat_ip_address
}