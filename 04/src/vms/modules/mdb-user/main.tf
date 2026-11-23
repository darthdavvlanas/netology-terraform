resource "yandex_mdb_mysql_database" "db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "random_password" "user_passwords" {
  for_each = { for user in var.db_users : user.name => user }

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "yandex_mdb_mysql_user" "users" {
  depends_on  = [yandex_mdb_mysql_database.db]
  for_each    = { for user in var.db_users : user.name => user }

  cluster_id = var.cluster_id
  name       = each.value.name
  password   = random_password.user_passwords[each.key].result

  permission {
    database_name = var.db_name
    roles         = each.value.roles
  }
}
