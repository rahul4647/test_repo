# Create an ELB
resource "aws_alb" "this" {
  name = var.name
  subnets = var.subnets
  security_groups = var.security_groups
  internal = false
}

# Create an ELB target group
resource "aws_alb_target_group" "this" {
  name = "my-target-group"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    path = "/health"
  }
}

# Create an ELB listener
resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.this.arn
    type = "forward"
  }
}

# Create an ELB listener rule
resource "aws_alb_listener_rule" "this" {
  listener_arn = aws_alb_listener.this.arn
  priority = 1
  action {
    target_group_arn = aws_alb_target_group.this.arn
    type = "forward"
  }
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}
