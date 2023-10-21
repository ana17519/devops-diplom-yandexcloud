variable "yc_id" {
  type = string
  default = ""
}

variable "yc_folder_id" {
  type = string
  default = ""
}

variable "yc_token" {
  type = string
  default = ""
}

variable "yc_zone" {
  type = string
  default = "ru-central1-a"
}
locals {
  virtual_machines = {
    stage = {
      "vm1" : 1,
      "vm2" : 1,
    },
    prod = {
      "vm3" : 1,
      "vm4" : 1,
    }
  }

  count = {
    stage = 1
  }
}