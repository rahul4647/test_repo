
resource "aws_secretsmanager_secret" "next_clerk_webhook_secret" {
  name = "next_clerk_webhook_secret"

  tags = {
    Name = "next-clerk-webhook-secret"
  }
}

resource "aws_secretsmanager_secret_version" "next_clerk_webhook_secret_version" {
  secret_id     = aws_secretsmanager_secret.next_clerk_webhook_secret.id
  secret_string = var.next_clerk_webhook_secret
}

resource "aws_secretsmanager_secret" "mongodb_url" {
  name = "mongodb_url"

  tags = {
    Name = "mongodb-url"
  }
}

resource "aws_secretsmanager_secret_version" "mongodb_url_version" {
  secret_id     = aws_secretsmanager_secret.mongodb_url.id
  secret_string = var.mongodb_url
}
