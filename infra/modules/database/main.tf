resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "main-docdb-cluster"
  master_username         = "docdbadmin"
  master_password         = var.docdb_master_password
  backup_retention_period = 14
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = false
  deletion_protection     = true
  storage_encrypted       = true

  vpc_security_group_ids = [var.database_security_group_id]

  tags = {
    Name = "main-docdb-cluster"
  }
}

resource "aws_docdb_cluster_instance" "main_instance" {
  count              = 2
  identifier         = "main-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = "db.t3.medium"
  apply_immediately  = true

  tags = {
    Name = "main-docdb-instance"
  }
}
