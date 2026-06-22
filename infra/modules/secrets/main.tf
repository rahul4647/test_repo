resource "aws_secretsmanager_secret" "next_clerk_webhook_secret" {
  name        = "NEXT_CLERK_WEBHOOK_SECRET"
  description = "Secret for Clerk Webhook"
}

resource "aws_secretsmanager_secret" "mongodb_url" {
  name        = "MONGODB_URL"
  description = "MongoDB connection URL"
}
