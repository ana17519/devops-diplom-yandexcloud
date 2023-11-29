terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

    backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     =  "asuhodola-ie7h"
    region     = "ru-central1-a"
    key        = "main-infra/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

// Creating a static access key
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = var.yc_service_account
  description        = "static access key for object storage"
}
