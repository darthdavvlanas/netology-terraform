resource "random_password" "mysql" {
    for_each = toset(["root","user"])
    length      = 16
    special     = false
    min_upper   = 1
    min_lower   = 1
    min_numeric = 1
}

resource "docker_image" "mysql" {
  name = "mysql:8"
}

resource "docker_container" "mysql" {
    image       = docker_image.mysql.image_id
    name        = "mysql"
    env = [
      "MYSQL_ROOT_PASSWORD=${random_password.mysql["root"].result}",
      "MYSQL_DATABASE=wordpress",
      "MYSQL_USER=wordpress",
      "MYSQL_PASSWORD=${random_password.mysql["user"].result}",
      "MYSQL_ROOT_HOST=%"
    ]
    ports {
      internal = 3306
      external = 3306
      ip       = "127.0.0.1"
    }
}