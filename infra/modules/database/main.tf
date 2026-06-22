resource "aws_docdb_cluster" "main" {
  cluster_identifier = "main-docdb-cluster"
  master_username    = "${var.db_username}"
  master_password    = "${var.db_password}"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  deletion_protection = true
  storage_encrypted   = true

  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "main-docdb-cluster"
  }
}

resource "aws_docdb_cluster_instance" "main" {
  count              = 1
  identifier         = "main-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = "db.t3.micro"

  tags = {
    Name = "main-docdb-instance-${count.index}"
  }
}

output "endpoint" {
  value = aws_docdb_cluster.main.endpoint
}
