# To always have a unique bucket name in this example
resource "random_string" "unique_id" {
  length  = 16
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "s3" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=master"

  bucket_name   = "netology-bucket-${random_string.unique_id.result}"
  max_size      = 1073741824
  versioning    = {
    enabled = true
  }
}

resource "yandex_iam_service_account" "remote-state" {
  name        = "remote-state"
  description = "Account for manage remote state"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "manage-s3" {
  folder_id   = var.folder_id
  role        = "storage.editor"
  member      = "serviceAccount:${yandex_iam_service_account.remote-state.id}"
}

resource "yandex_iam_service_account_static_access_key" "remote-state-static-key" {
  depends_on          = [yandex_resourcemanager_folder_iam_member.manage-s3]
  service_account_id  = yandex_iam_service_account.remote-state.id
  description         = "Key for access service account to S3 bucket with state"
}