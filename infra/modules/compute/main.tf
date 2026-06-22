# Create an ECS cluster
resource "aws_ecs_cluster" "this" {
  name = "example-cluster"
}

# Create an ECS task definition
resource "aws_ecs_task_definition" "this" {
  family = "example-task"
  cpu = "1024"
  memory = "2048"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  container_definitions = jsonencode([
    {
      name = "example-container"
      image = "example-image:latest"
      portMappings = [
        {
          containerPort = 3000
          hostPort = 3000
          protocol = "tcp"
        }
      ]
    }
  ])
}

# Create an ECS service
resource "aws_ecs_service" "this" {
  name = "example-service"
  cluster = aws_ecs_cluster.this.name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count = 2
  launch_type = "FARGATE"
  network_configuration {
    subnets = [aws_subnet.public[0].id, aws_subnet.public[1].id]
    security_groups = [aws_security_group.ecs.id]
    assign_public_ip = "ENABLED"
  }
}