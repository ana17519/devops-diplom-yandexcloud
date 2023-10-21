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

resource "yandex_vpc_subnet" "subnet_c" {
  name           = "subnet_c"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.131.0.0/24"]
  zone           = "ru-central1-c"
}
//Intel Ice Lake 2vCPU, fraction 20%, 2 Ram, 8Gb hdd, preemtible, public IP
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm" {
  name        = "${"test"}-${count.index}"
  count       = 3
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = var.yc_zone

  resources {
    cores  = "2"
    memory = "2"
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat       = true
  }

  metadata = {
     ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}
