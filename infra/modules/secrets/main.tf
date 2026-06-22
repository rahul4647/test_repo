resource "aws_secretsmanager_secret" "next_clerk_webhook_secret" {
  name = "next_clerk_webhook_secret"
}

resource "aws_secretsmanager_secret" "mongodb_url" {
  name = "mongodb_url"
}
