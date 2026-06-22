# Create an ECS cluster
resource "aws_ecs_cluster" "this" {
  name = "main-cluster"
}

# Create an ECS task definition
resource "aws_ecs_task_definition" "this" {
  family                = "main-task"
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  container_definitions = jsonencode([
    {
      name      = "main-container"
      image      = "aws_account_id.dkr.ecr.us-east-1.amazonaws.com/main-repo:latest"
      cpu        = var.cpu
      memory     = var.memory
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# Create an IAM role for ECS task execution
resource "aws_iam_role" "ecs_task_execution" {
  name        = "ecs-task-execution"
  description = "ECS task execution role"

  assume_role_policy = jsonencode(
    {
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
    }
  )
}

# Create an IAM policy for ECS task execution
resource "aws_iam_policy" "ecs_task_execution" {
  name        = "ecs-task-execution"
  description = "ECS task execution policy"

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Resource = "arn:aws:logs:*:*:log-group:/ecs/main:*
          Effect    = "Allow"
        }
      ]
    }
  )
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}
