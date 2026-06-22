# Create a Secrets Manager secret
resource "aws_secretsmanager_secret" "this" {
  name = "main-secret"
}

# Create a Secrets Manager secret version
resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(
    {
      NEXT_CLERK_WEBHOOK_SECRET = "secret-value"
      MONGODB_URL = "mongodb-url"
    }
  )
}
