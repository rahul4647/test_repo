# Create an ALB
resource "aws_alb" "this" {
  name            = "main-alb"
  subnets         = var.subnet_ids
  security_groups = [aws_security_group.alb.id]
}

# Create an ALB target group
resource "aws_alb_target_group" "this" {
  name     = "main-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    path                = "/health"
    interval            = 10
  }
}

# Create an ALB listener
resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.this.arn
    type              = "forward"
  }
}

# Create an ALB listener certificate
resource "aws_alb_listener_certificate" "this" {
  load_balancer_arn = aws_alb.this.arn
  certificate_arn    = "arn:aws:acm:us-east-1:aws_account_id:certificate/certificate-id"
}

# Create a security group for the ALB
resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "ALB security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
