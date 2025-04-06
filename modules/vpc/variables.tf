variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_id" {
  description = "ID of the public subnet for the NAT Gateway"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for route table association"
  type        = list(string)
}