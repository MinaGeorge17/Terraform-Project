# Public Load Balancer
resource "aws_lb" "public_lb" {
  name               = "public-lb-minag"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg_id]
  subnets            = var.public_subnet_ids
  tags = {
    Name = "Public_LB_MinaG"
  }
}

resource "aws_lb_target_group" "public_tg" {
  name     = "public-tg-minag"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "public_ec2_AZ1" {
  target_group_arn = aws_lb_target_group.public_tg.arn
  target_id        = var.public_ec2_AZ1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "public_ec2_AZ2" {
  target_group_arn = aws_lb_target_group.public_tg.arn
  target_id        = var.public_ec2_AZ2_id
  port             = 80
}

# Private Load Balancer
resource "aws_lb" "private_lb" {
  name               = "private-lb-minag"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private_sg_id]
  subnets            = var.private_subnet_ids
  tags = {
    Name = "Private_LB_MinaG"
  }
}

resource "aws_lb_target_group" "private_tg" {
  name     = "private-tg-minag"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.private_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_tg.arn
  }
}

# Combined Private EC2 Target Group Attachments
resource "aws_lb_target_group_attachment" "private_ec2" {
  for_each = {
    "AZ1" = var.private_ec2_AZ1_id
    "AZ2" = var.private_ec2_AZ2_id
  }
  target_group_arn = aws_lb_target_group.private_tg.arn
  target_id        = each.value
  port             = 80
}