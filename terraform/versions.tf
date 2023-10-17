terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

// Creating a static access key
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "aje4ofq2hpt96gqf6s7k"
  description        = "static access key for object storage"
}

# random-string
resource "random_string" "random" {
  length              = 4
  special             = false
  upper               = false
}
//https://cloud.yandex.ru/docs/storage/operations/objects/edit-acl
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "asuhodola-${random_string.random.result}"
  acl = "public-read"
}

