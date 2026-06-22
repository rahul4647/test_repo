resource "aws_secretsmanager_secret" "clerk_webhook" {
  name = "NEXT_CLERK_WEBHOOK_SECRET"
}

resource "aws_secretsmanager_secret" "mongodb_url" {
  name = "MONGODB_URL"
}
