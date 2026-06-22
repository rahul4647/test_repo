resource "aws_ecs_cluster" "main" {
  name = "main-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name  = "app-container"
      image = "node:20@sha256:<image-digest>"
      port_mappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
          protocol      = "tcp"
        }
      ]
    }
  ])

  execution_role_arn = module.iam.ecs_task_execution_role_arn
}

resource "aws_ecs_service" "app" {
  cluster        = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count  = 1

  network_configuration {
    subnets         = module.networking.subnet_ids
    security_groups = [module.networking.ecs_sg_id]
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}
