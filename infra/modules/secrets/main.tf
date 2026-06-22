# Create secrets
resource "aws_secretsmanager_secret" "this" {
  name = "my-secret"
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    NEXT_CLERK_WEBHOOK_SECRET = "my-next-clerk-webhook-secret"
    MONGODB_URL = "my-mongodb-url"
  })
}
