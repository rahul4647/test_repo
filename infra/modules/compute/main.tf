resource "aws_ecs_cluster" "main" {
  name = "main-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  container_definitions    = jsonencode([
    {
      name      = "app"
      image     = "nginx@sha256:abc123"
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = module.iam.ecs_task_execution_role_arn
}

resource "aws_ecs_service" "app" {
  name            = "app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.min_tasks
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [for subnet in aws_subnet.public : subnet.id]
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "app"
    container_port   = 3000
  }

  deployment_controller {
    type = "ECS"
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  policy_name      = "scaleUp"
  scaling_adjustment = 1
  adjustment_type  = "ChangeInCapacity"
  cooldown         = 300
  min_adjustment_magnitude = 1

  target_tracking_scaling_policy_configuration {
    target_value       = var.scale_threshold
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

variable "cpu" {
  type    = number
  default = 1024
}

variable "memory" {
  type    = number
  default = 2048
}

variable "min_tasks" {
  type    = number
  default = 2
}

variable "max_tasks" {
  type    = number
  default = 4
}

variable "scale_threshold" {
  type    = number
  default = 60
}

variable "alb_target_group_arn" {
  type = string
}

output "alb_target_group_arn" {
  value = aws_alb_target_group.main.arn
}
