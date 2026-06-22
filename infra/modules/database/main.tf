resource "aws_docdb_cluster" "app" {
  cluster_identifier      = "app-cluster"
  master_username         = "<USERNAME>"
  master_password         = "<PASSWORD>"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = false
  deletion_protection     = true
  storage_encrypted       = true

  vpc_security_group_ids = [var.db_security_group_id]
}

resource "aws_docdb_cluster_instance" "app" {
  identifier = "app-instance"
  cluster_identifier = aws_docdb_cluster.app.id
  instance_class = "db.t3.micro"
}
