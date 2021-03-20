resource "aws_route_table_association" "route_table_associate" {
  subnet_id      = var.subnet
  route_table_id = var.route_table
}

