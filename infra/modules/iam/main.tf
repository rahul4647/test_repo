# Create an IAM role for ECS task execution
resource "aws_iam_role" "ecs_task_execution" {
  name = "example-ecs-task-execution"
  assume_role_policy = jsonencode(
    {
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
    }
  )
}

# Create an IAM policy for ECS task execution
resource "aws_iam_policy" "ecs_task_execution" {
  name = "example-ecs-task-execution-policy"
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Effect = "Allow"
          Resource = "arn:aws:logs:*:*:log-group:/ecs/*"
        }
      ]
    }
  )
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}