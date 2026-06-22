# Create a secrets manager secret
resource "aws_secretsmanager_secret" "this" {
  name = var.name
}

# Create a secrets manager secret version
resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret)
}
