resource "aws_instance" "public_ec2_AZ1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = var.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo 'Hello from Public Subnet AZ1' > /tmp/hello.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo 'public-ip1 ${self.public_ip}' >> all-ips.txt"
  }

  tags = {
    Name = "Public_EC2_AZ1_MinaG"
  }
}

resource "aws_instance" "public_ec2_AZ2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[1]
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = var.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo 'Hello from Public Subnet AZ2' > /tmp/hello.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo 'public-ip2 ${self.public_ip}' >> all-ips.txt"
  }

  tags = {
    Name = "Public_EC2_AZ2_MinaG"
  }
}

resource "aws_instance" "private_ec2_AZ1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[0]
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = var.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo 'Hello from Private Subnet AZ1' > /tmp/hello.txt"
    ]
    connection {
      type             = "ssh"
      user             = "ec2-user"
      private_key      = file(var.private_key_path)
      host             = self.private_ip
      bastion_host     = var.public_ip_AZ1
      bastion_user     = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }

  tags = {
    Name = "Private_EC2_AZ1_MinaG"
  }
}

resource "aws_instance" "private_ec2_AZ2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[1]
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = var.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo 'Hello from Private Subnet AZ2' > /tmp/hello.txt"
    ]
    connection {
      type             = "ssh"
      user             = "ec2-user"
      private_key      = file(var.private_key_path)
      host             = self.private_ip
      bastion_host     = var.public_ip_AZ1
      bastion_user     = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }

  tags = {
    Name = "Private_EC2_AZ2_MinaG"
  }
}