resource "aws_ecs_cluster" "main" {
  name = "main-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = module.iam.ecs_execution_role_arn
  container_definitions    = jsonencode([
    {
      name  = "app"
      image = "node:18.2.0@sha256:abcdefghijk"
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/app"
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "app" {
  cluster        = aws_ecs_cluster.main.id
  desired_count  = 1
  launch_type    = "FARGATE"
  task_definition = aws_ecs_task_definition.app.arn
  network_configuration {
    subnets         = module.networking.private_subnets
    security_groups = [module.networking.ecs_sg_id]
  }
}
