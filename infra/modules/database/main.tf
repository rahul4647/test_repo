
resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "main-docdb"
  master_username         = "docdbuser"
  master_password         = "${var.mongodb_url}"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  storage_encrypted       = true
  deletion_protection     = true
}

resource "aws_docdb_cluster_instance" "main" {
  identifier          = "main-docdb-instance"
  cluster_identifier  = aws_docdb_cluster.main.id
  instance_class      = "db.t3.micro"
  apply_immediately   = true
}
