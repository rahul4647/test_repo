# Create a Secrets Manager secret
resource "aws_secretsmanager_secret" "this" {
  name = "example-secret"
}

# Create a Secrets Manager secret version
resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(
    {
      NEXT_CLERK_WEBHOOK_SECRET = "example-secret"
      MONGODB_URL = "example-mongodb-url"
    }
  )
}