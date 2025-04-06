# Data Source for AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# VPC Module
module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  public_subnet_id = module.subnet.public_AZ1_subnet_id
  private_subnet_ids = [
    module.subnet.private_AZ1_subnet_id,
    module.subnet.private_AZ2_subnet_id
  ]
}

# Subnet Module
module "subnet" {
  source             = "./modules/subnet"
  vpc_id             = module.vpc.vpc_id
  public_AZ1_cidr    = var.public_AZ1_cidr
  private_AZ1_cidr   = var.private_AZ1_cidr
  public_AZ2_cidr    = var.public_AZ2_cidr
  private_AZ2_cidr   = var.private_AZ2_cidr
}

# Route Table Module
module "route_table" {
  source         = "./modules/route-table"
  vpc_id         = module.vpc.vpc_id
  public_subnet_ids = [
    module.subnet.public_AZ1_subnet_id,
    module.subnet.public_AZ2_subnet_id
  ]
  igw_id = module.vpc.igw_id
}

# Security Group Module
module "security_group" {
  source   = "./modules/security-group"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
}

# EC2 Module
module "ec2" {
  source             = "./modules/ec2"
  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = var.instance_type
  public_subnet_ids  = [
    module.subnet.public_AZ1_subnet_id,
    module.subnet.public_AZ2_subnet_id
  ]
  private_subnet_ids = [
    module.subnet.private_AZ1_subnet_id,
    module.subnet.private_AZ2_subnet_id
  ]
  public_sg_id       = module.security_group.public_sg_id
  private_sg_id      = module.security_group.private_sg_id
  key_name           = var.key_name
  private_key_path   = var.private_key_path
  public_ip_AZ1      = var.public_ip_AZ1  # Use variable instead of output for now
}

# Load Balancer Module
module "load_balancer" {
  source              = "./modules/load-balancer"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = [
    module.subnet.public_AZ1_subnet_id,
    module.subnet.public_AZ2_subnet_id
  ]
  private_subnet_ids  = [
    module.subnet.private_AZ1_subnet_id,
    module.subnet.private_AZ2_subnet_id
  ]
  public_sg_id        = module.security_group.public_sg_id
  private_sg_id       = module.security_group.private_sg_id
  private_ec2_AZ1_id  = module.ec2.private_ec2_AZ1_id
  private_ec2_AZ2_id  = module.ec2.private_ec2_AZ2_id
  public_ec2_AZ1_id   = module.ec2.public_ec2_AZ1_id
  public_ec2_AZ2_id   = module.ec2.public_ec2_AZ2_id
}

#Creating s3  for remote tfstatefile
resource "aws_s3_bucket" "minatfstatebucket" {
  bucket = "minatfstatebucket"
  tags = {
    Name        = "minatfstatebucket"
  }
}