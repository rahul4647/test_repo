resource "aws_secretsmanager_secret" "next_clerk_webhook_secret" {
  name = "NEXT_CLERK_WEBHOOK_SECRET"
}

resource "aws_secretsmanager_secret_version" "next_clerk_webhook_secret_version" {
  secret_id     = aws_secretsmanager_secret.next_clerk_webhook_secret.id
  secret_string = jsonencode({
    NEXT_CLERK_WEBHOOK_SECRET = "<SECRET>"
  })
}

resource "aws_secretsmanager_secret" "mongodb_url" {
  name = "MONGODB_URL"
}

resource "aws_secretsmanager_secret_version" "mongodb_url_version" {
  secret_id     = aws_secretsmanager_secret.mongodb_url.id
  secret_string = jsonencode({
    MONGODB_URL = "<SECRET>"
  })
}
