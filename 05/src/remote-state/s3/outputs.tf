output "bucket_name" {
  description = "The name of the bucket."
  value       = module.s3.bucket_name
}

output "access_key_id" {
  value     = yandex_iam_service_account_static_access_key.remote-state-static-key.access_key
  sensitive = true
}

output "secret_key" {
  value     = yandex_iam_service_account_static_access_key.remote-state-static-key.secret_key
  sensitive = true
}

output "backend_config" {
  value = <<-EOT
    bucket     = "${module.s3.bucket_name}"
    
    access_key = "YCAJE..."
    secret_key = "YCOJ..."

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
  EOT
}
