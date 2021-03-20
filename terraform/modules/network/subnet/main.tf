####### Subnet ########

## Public Subnets ##
resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnets_cidr
  availability_zone       = var.azs
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_name
  }
}

output "subnet_id" {
  value = aws_subnet.subnet.id
}
//
//resource "aws_subnet" "public_subnet_b" {
//  vpc_id                  = var.vpc_id
//  cidr_block              = var.public_subnets_cidr_b
//  availability_zone       = var.azs_b
//  map_public_ip_on_launch = true
//  tags = {
//    Name = "Public-Subnet-b"
//  }
//}
//
//resource "aws_subnet" "private_subnet_a" {
//  vpc_id                  = var.vpc_id
//  cidr_block              = var.private_subnets_cidr_a
//  availability_zone       = var.azs_a
//  map_public_ip_on_launch = false
//  tags = {
//    Name = "Private-Subnet-a"
//  }
//}
//
//resource "aws_subnet" "private_subnet_b" {
//  vpc_id                  = var.vpc_id
//  cidr_block              = var.private_subnets_cidr_b
//  availability_zone       = var.azs_b
//  map_public_ip_on_launch = false
//  tags = {
//    Name = "Private-Subnet-b"
//  }
//}
