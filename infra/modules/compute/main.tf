resource "aws_ecs_cluster" "main" {
  name = "main-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  network_mode             = "awsvpc"
  container_definitions    = jsonencode([
    {
      name      = "app-container"
      image     = "node:18.2.0@sha256:<digest>"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [{
        containerPort = 3000
        hostPort      = 3000
      }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/app"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
  execution_role_arn = var.ecs_task_execution_role_arn
}

resource "aws_ecs_service" "app" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = [module.networking.public_subnets]
    security_groups = [module.networking.ecs_sg_id]
  }
}
