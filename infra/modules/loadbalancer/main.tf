# Create an ALB
resource "aws_alb" "this" {
  name = "my-alb"
  subnets = [aws_subnet.public[0].id]
  security_groups = [aws_security_group.alb.id]
}

# Create a security group for ALB
resource "aws_security_group" "alb" {
  vpc_id = var.vpc_id
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-alb-sg"
  }
}

# Create an ALB listener
resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.this.arn
    type = "forward"
  }
}

# Create an ALB target group
resource "aws_alb_target_group" "this" {
  name = "my-alb-target-group"
  port = var.app_port
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    path = "/health"
  }
}

# Create an ALB listener rule
resource "aws_alb_listener_rule" "this" {
  listener_arn = aws_alb_listener.this.arn
  priority = 1
  action {
    target_group_arn = aws_alb_target_group.this.arn
    type = "forward"
  }
  condition {
    field = "path-pattern"
    values = ["/health"]
  }
}
