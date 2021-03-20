resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.route_cidr_block #### "0.0.0.0/0"
    gateway_id = var.gateway_id ###aws_internet_gateway.igw.id
  }
  tags = var.route_table_tags
}

output "route_table_id" {
  value = aws_route_table.public_rt.id
}
//resource "aws_route_table" "private_rt" {
//  vpc_id = vpc_id
//  route {
//    cidr_block     = var.route_cidr_block
//    nat_gateway_id = var.nat_gateway_id
//  }
//  tags = var.private_route_table_tags
//}



