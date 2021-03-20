####### Subnet ########

//variable "public_subnets_cidr_a" {
//  default = "10.95.1.0/24"
//}
//
//variable "public_subnets_cidr_b" {
//  default = "10.95.2.0/24"
//}
//
//variable "private_subnets_cidr_a" {
//  default = "10.95.3.0/24"
//}
//
//variable "private_subnets_cidr_b" {
//  default = "10.95.4.0/24"
//}
//
//variable "azs_a" {
//  default = "us-west-2a"
//}
//
//variable "azs_b" {
//  default = "us-west-2b"
//}

variable "vpc_id" {}
variable "subnet_name" {}
variable "subnets_cidr" {}
variable "azs" {}