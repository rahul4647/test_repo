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
          Resource = "arn:aws:logs:*:*:log-group:/ecs/main:*"
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
