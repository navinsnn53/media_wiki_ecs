##### NAT ######
resource "aws_eip" "eip" {
  vpc  = true
  tags = var.eip_tags
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.public_subnet
  tags = var.nat_tags
}

output "nat_id" {
  value = aws_nat_gateway.nat.id
}