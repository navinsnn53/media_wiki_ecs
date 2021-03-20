###### NAT ######

variable "eip_tags" {
  default = {
    "Name" = "NAT_GW"
  }
}

variable "nat_tags" {
  default = {
    "Name" = "NAT_GW"
  }
}

variable "public_subnet" {}