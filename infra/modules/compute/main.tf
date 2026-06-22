# Create an ECS cluster
resource "aws_ecs_cluster" "this" {
  name = "my-ecs-cluster"
}

# Create an ECS task definition
resource "aws_ecs_task_definition" "this" {
  family = "my-ecs-task"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 1024
  memory = 2048
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  container_definitions = jsonencode([
    {
      name = "my-container"
      image = "my-docker-image"
      portMappings = [
        {
          containerPort = var.app_port
          hostPort = var.app_port
          protocol = "tcp"
        }
      ]
    }
  ])
}

# Create an ECS service
resource "aws_ecs_service" "this" {
  name = "my-ecs-service"
  cluster = aws_ecs_cluster.this.name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count = 2
  launch_type = "FARGATE"
  network_configuration {
    subnets = [aws_subnet.public[0].id]
    security_groups = [aws_security_group.ecs.id]
    assign_public_ip = "ENABLED"
  }
}

# Create a security group for ECS
resource "aws_security_group" "ecs" {
  vpc_id = var.vpc_id
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    cidr_blocks = [aws_security_group.documentdb.cidr_blocks[0]]
  }
  tags = {
    Name = "my-ecs-sg"
  }
}

# Create IAM role for ECS task execution
resource "aws_iam_role" "ecs_task_execution" {
  name = "my-ecs-task-execution"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}
