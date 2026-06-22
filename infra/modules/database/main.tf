resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "main-docdb-cluster"
  master_username         = "admin"
  master_password         = "<password>" # Never hardcode passwords, use secrets management.
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  deletion_protection     = true
  storage_encrypted       = true

  vpc_security_group_ids = [var.database_security_group_id]
}

resource "aws_docdb_cluster_instance" "main" {
  count                = 1
  identifier           = "main-docdb-instance-${count.index}"
  cluster_identifier   = aws_docdb_cluster.main.id
  instance_class       = "db.t3.micro"
  engine_version       = "3.6.0"
  apply_immediately    = true
  publicly_accessible  = false
}
