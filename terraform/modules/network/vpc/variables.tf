##### VPC ######

variable "create_vpc" {
  default = "true"
}
variable "cidr" {
  default = "10.95.0.0/16"
}
variable "enable_dns_hostnames" {
  default = true
}
variable "enable_dns_support" {
  default = true
}
variable "vpc_tags" {
  default = {"Name" = "media-wiki"}
}