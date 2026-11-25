provider "vault" {
 address = "http://127.0.0.1:8200"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

# Можно обратиться не к словарю, а конкретному ключу:
# terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)

resource "vault_kv_secret_v2" "example2" {
  mount = "secret"
  name  = "example2"
  
  data_json = jsonencode({
    test    = "congrats!!!!"
  })
}

data "vault_generic_secret" "vault_example2" {
  depends_on    = [vault_kv_secret_v2.example2]
  path          = "secret/example2"
}

output "vault_example2" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example2.data)}"
} 
