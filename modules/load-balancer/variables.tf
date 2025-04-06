variable "vpc_id" {
  description = "ID of the VPC"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_sg_id" {
  description = "ID of the public security group"
}

variable "public_ec2_AZ1_id" {
  description = "ID of the public EC2 instance in AZ1"
}

variable "public_ec2_AZ2_id" {
  description = "ID of the public EC2 instance in AZ2"
}

variable "private_sg_id" {
  description = "ID of the private security group"
}

variable "private_ec2_AZ1_id" {
  description = "ID of the private EC2 instance in AZ1"
  default     = null  # Optional for first apply
}

variable "private_ec2_AZ2_id" {
  description = "ID of the private EC2 instance in AZ2"
  default     = null  # Optional for first apply
}