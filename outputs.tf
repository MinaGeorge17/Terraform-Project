output "public_ec2_AZ1_id" {
  value = module.ec2.public_ec2_AZ1_id
}

output "public_ec2_AZ2_id" {
  value = module.ec2.public_ec2_AZ2_id
}

output "private_ec2_AZ1_id" {
  value = module.ec2.private_ec2_AZ1_id
}

output "private_ec2_AZ2_id" {
  value = module.ec2.private_ec2_AZ2_id
}

output "public_ips" {
  value = module.ec2.public_ips
}

output "public_ec2_AZ1_ip" {
  value = module.ec2.public_ec2_AZ1_ip
}

output "public_lb_dns" {
  value = module.load_balancer.public_lb_dns
}