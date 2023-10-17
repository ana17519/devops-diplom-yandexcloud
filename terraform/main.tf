provider "yandex" {
  cloud_id  = var.yc_id
  token = var.yc_token
  folder_id = var.yc_folder_id
}

resource "yandex_vpc_network" "net" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "subnet_a"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.129.0.0/24"]
  zone           = var.yc_zone
}

resource "yandex_vpc_subnet" "subnet_b" {
  name           = "subnet_b"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.130.0.0/24"]
  zone           = "ru-central1-b"
}

