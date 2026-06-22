resource "aws_secretsmanager_secret" "db_password" {
  name = "db-password"

  recovery_window_in_days = 30

  tags = {
    Name = "db-password"
  }
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}

variable "db_password" {
  type = string
}
