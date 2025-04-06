output "vpc_id" {
  value = aws_vpc.vpc_main.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_gw_id" {
  value = aws_nat_gateway.nat_gw.id
}