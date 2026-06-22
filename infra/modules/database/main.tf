resource "aws_docdb_cluster" "main" {
  cluster_identifier = "docdb-cluster"
  engine             = "docdb"
  master_username    = "${var.db_username}"
  master_password    = aws_secretsmanager_secret_version.db_password.secret_string
  backup_retention_period = 14
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name = var.db_subnet_group_name
  storage_encrypted   = true
  deletion_protection = true

  tags = {
    Name = "docdb-cluster"
  }
}

resource "aws_docdb_cluster_instance" "main" {
  count              = var.db_instance_count
  identifier         = "docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = "db.t3.medium"

  tags = {
    Name = "docdb-instance-${count.index}"
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [var.ecs_sg_id]
  }

  tags = {
    Name = "db-sg"
  }
}

variable "db_username" {
  type = string
}

variable "db_instance_count" {
  type    = number
  default = 2
}

variable "db_subnet_group_name" {
  type = string
}

variable "ecs_sg_id" {
  type = string
}
