variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_AZ1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_AZ1_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "public_AZ2_cidr" {
  type    = string
  default = "10.0.3.0/24"
}

variable "private_AZ2_cidr" {
  type    = string
  default = "10.0.4.0/24"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "my-key-pair"
}

variable "private_key_path" {
  type    = string
  default = "/home/minab/my-key-pair.pem"
}

variable "public_ip_AZ1" {
  type    = string
  default = ""
}