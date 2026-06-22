resource "aws_secretsmanager_secret" "clerk_webhook_secret" {
  name = "NEXT_CLERK_WEBHOOK_SECRET"
}

resource "aws_secretsmanager_secret_version" "clerk_webhook_secret" {
  secret_id     = aws_secretsmanager_secret.clerk_webhook_secret.id
  secret_string = var.next_clerk_webhook_secret
}

resource "aws_secretsmanager_secret" "mongodb_url" {
  name = "MONGODB_URL"
}

resource "aws_secretsmanager_secret_version" "mongodb_url" {
  secret_id     = aws_secretsmanager_secret.mongodb_url.id
  secret_string = var.mongodb_url
}
