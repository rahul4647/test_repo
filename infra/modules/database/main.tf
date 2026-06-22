resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "main-cluster"
  master_username         = "admin"
  master_password         = "<secure-password>"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = false
  deletion_protection     = true
  storage_encrypted       = true
  vpc_security_group_ids  = [module.networking.db_sg_id]
}

resource "aws_docdb_cluster_instance" "main" {
  count               = 1
  identifier          = "main-cluster-instance-${count.index}"
  cluster_identifier  = aws_docdb_cluster.main.id
  instance_class      = "db.t3.micro"
  engine_version      = "4.0"
}
