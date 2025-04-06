resource "aws_subnet" "public_AZ1" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_AZ1_cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet_AZ1_MinaG"
  }
}

resource "aws_subnet" "public_AZ2" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_AZ2_cidr
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet_AZ2_MinaG"
  }
}

resource "aws_subnet" "private_AZ1" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_AZ1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private_Subnet_AZ1_MinaG"
  }
}

resource "aws_subnet" "private_AZ2" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_AZ2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "Private_Subnet_AZ2_MinaG"
  }
}
