variable "vpc_id" {
  description = "ID of the VPC"
}

variable "igw_id" {
  description = "ID of the Internet Gateway"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to associate with the route table"
  type        = list(string)
}