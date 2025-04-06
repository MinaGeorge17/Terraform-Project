output "public_ec2_AZ1_id" {
  value = aws_instance.public_ec2_AZ1.id
}

output "public_ec2_AZ2_id" {
  value = aws_instance.public_ec2_AZ2.id
}

output "private_ec2_AZ1_id" {
  value = aws_instance.private_ec2_AZ1.id
}

output "private_ec2_AZ2_id" {
  value = aws_instance.private_ec2_AZ2.id
}

output "public_ips" {
  value = [
    aws_instance.public_ec2_AZ1.public_ip,
    aws_instance.public_ec2_AZ2.public_ip
  ]
}

output "public_ec2_AZ1_ip" {
  value = aws_instance.public_ec2_AZ1.public_ip
}