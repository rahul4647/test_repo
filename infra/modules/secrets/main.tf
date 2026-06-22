resource "aws_secretsmanager_secret" "clerk_webhook_secret" {
  name = "${var.app_name}-clerk-webhook-secret"

  tags = {
    Name = "${var.app_name}-clerk-webhook-secret"
  }
}

resource "aws_secretsmanager_secret" "mongodb_url" {
  name = "${var.app_name}-mongodb-url"

  tags = {
    Name = "${var.app_name}-mongodb-url"
  }
}