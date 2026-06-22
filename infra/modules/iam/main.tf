# Create an IAM role
resource "aws_iam_role" "this" {
  name = var.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = var.service
        }
        Effect = "Allow"
      }
    ]
  })
}

# Create an IAM policy
resource "aws_iam_policy" "this" {
  name = var.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = var.actions
        Resource = var.resources
        Effect = "Allow"
      }
    ]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "this" {
  role = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
