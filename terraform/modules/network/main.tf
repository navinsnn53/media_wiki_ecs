provider "aws" {
  region = "us-west-2"
  profile = "default"
}









#### Route ######


## Route table associations ##


resource "aws_route_table_association" "pub_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

## Route table associations ##
resource "aws_route_table_association" "pvt_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "pvt_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}
