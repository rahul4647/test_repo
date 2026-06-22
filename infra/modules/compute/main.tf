resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-ecs-cluster"
}

resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.main.id
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [module.networking.subnet_ids]
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = module.loadbalancer.alb_target_group_arn
    container_name   = "${var.app_name}-container"
    container_port   = 3000
  }
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = module.networking.vpc_id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [module.networking.db_sg_id]
  }

  tags = {
    Name = "${var.app_name}-ecs-sg"
  }
}
