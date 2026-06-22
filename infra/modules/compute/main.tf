resource "aws_ecs_cluster" "app" {
  name = "app-cluster"
}

resource "aws_ecs_service" "app" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.ecs_subnet_ids
    security_groups = [var.ecs_security_group_id]
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      name  = "app-container"
      image = "node:18.2.0@sha256:<DIGEST>"
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = [
        {
          name  = "NEXT_CLERK_WEBHOOK_SECRET"
          value = "<SECRET>"
        },
        {
          name  = "MONGODB_URL"
          value = "<SECRET>"
        }
      ]
    }
  ])

  execution_role_arn = aws_iam_role.ecs_task_execution.arn
}
