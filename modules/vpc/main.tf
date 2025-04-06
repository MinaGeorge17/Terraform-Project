resource "aws_vpc" "vpc_main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC_MinaG"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "IGW_MinaG"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"  # Updated from vpc = true
  tags = {
    Name = "NAT_EIP_MinaG"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
  tags = {
    Name = "NAT_GW_MinaG"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "Private_Route_Table_MinaG"
  }
}

resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_rt.id
}