output "db_users_info" {
  description = "List of created users with roles and database"
  value = [
    for user in yandex_mdb_mysql_user.users : {
      username = user.name
      database = var.db_name
      roles    = [for p in user.permission : p.roles][0]
    }
  ]
}
