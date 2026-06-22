# Create an Application Load Balancer
resource "aws_lb" "this" {
  name = "example-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = [aws_subnet.public[0].id, aws_subnet.public[1].id]
}

# Create an ALB target group
resource "aws_lb_target_group" "this" {
  name = "example-target-group"
  port = 3000
  protocol = "HTTP"
  vpc_id = aws_vpc.this.id
  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 10
    timeout = 5
    interval = 10
    path = "/health"
    port = "traffic-port"
  }
}

# Create an ALB listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type = "forward"
  }
}

# Create an ALB listener rule
resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.this.arn
  priority = 1
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
  condition {
    field = "path-pattern"
    values = ["/health"]
  }
}