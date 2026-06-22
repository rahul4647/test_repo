resource "aws_secretsmanager_secret" "clerk_webhook" {
  name = "NEXT_CLERK_WEBHOOK_SECRET"
}

resource "aws_secretsmanager_secret" "mongodb_url" {
  name = "MONGODB_URL"
}

resource "aws_secretsmanager_secret_version" "clerk_webhook_version" {
  secret_id     = aws_secretsmanager_secret.clerk_webhook.id
  secret_string = "<clerk_webhook_secret>"
}

resource "aws_secretsmanager_secret_version" "mongodb_url_version" {
  secret_id     = aws_secretsmanager_secret.mongodb_url.id
  secret_string = "<mongodb_connection_string>"
}