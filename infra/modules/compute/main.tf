
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
      name      = "app-container"
      image     = "node:20@sha256:example"
      portMappings = [{
        containerPort = 3000
        hostPort      = 3000
      }]
      environment = [
        {
          name  = "NEXT_CLERK_WEBHOOK_SECRET"
          value = var.next_clerk_webhook_secret
        },
        {
          name  = "MONGODB_URL"
          value = var.mongodb_url
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  cluster        = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count  = 1
  launch_type    = "FARGATE"

  network_configuration {
    subnets         = var.ecs_subnets
    security_groups = [aws_security_group.ecs_sg.id]
  }
}
