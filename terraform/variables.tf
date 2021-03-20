################################## Network ########################################################
################################ VPC ####################################
variable "vpc_cidr" {
  default = "10.96.0.0/16"
}

########################### Subnet ####################################


variable "az_a" {
  default = "us-west-2a"
}

variable "az_b" {
  default = "us-west-2b"
}

variable "subnets_cidr_public_a" {
  default = "10.96.1.0/24"
}

variable "subnets_cidr_public_b" {
  default = "10.96.2.0/24"
}
variable "subnets_cidr_private_a" {
  default = "10.96.3.0/24"
}
variable "subnets_cidr_private_b" {
  default = "10.96.4.0/24"
}

variable "subnet_name_public_a" {
  default = "public_subnet_a"
}
variable "subnet_name_public_b" {
  default = "public_subnet_b"
}

variable "subnet_name_private_a" {
  default = "private_subnet_a"
}
variable "subnet_name_private_b" {
  default = "private_subnet_b"
}

########################Route Table ########################

variable "route_cidr_block" {
  default = "0.0.0.0/0"
}

variable "public_route_table_tags" {
  default = {"Name"="public_route_table"}
}
variable "private_route_table_tags" {
  default = {"Name" = "private_route_table"}
}



########################################## ECS Component ########################################################

variable "env" {}
variable "ecs_lc_name" {}
variable "ecs_ami_id" {}
variable "ecs_instance_type" {}
variable "ecs_key_name" {}
variable "ecs_sg_list_id" {}
variable "ecs_cluster_name" {}
variable "ecs_asg_name" {}
variable "ecs_asg_max_size" {}
variable "ecs_asg_min_size" {}
variable "ecs_asg_desired_size" {}
variable "ecs_asg_subnet_list_id" {}
variable "ecs_instance_volume" {}
variable "ecs_asg_instance_health_check_period" {}
variable "ecs_asg_protect_scale_in" {}


