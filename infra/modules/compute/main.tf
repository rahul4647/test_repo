# Create an ECS cluster
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

# Create an ECS task definition
resource "aws_ecs_task_definition" "this" {
  family = "my-task-definition"
  cpu = var.cpu
  memory = var.memory
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.this.arn
  container_definitions = jsonencode([
    {
      name = "my-container"
      image = "my-image"
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

# Create an IAM role
resource "aws_iam_role" "this" {
  name = "my-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })
}
