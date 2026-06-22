resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "main-db"
  engine                  = "docdb"
  master_username         = "username"
  master_user_password    = "${var.db_password}"
  db_subnet_group_name    = "${aws_docdb_subnet_group.main.id}"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  storage_encrypted       = true
  deletion_protection     = true
}

resource "aws_docdb_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = module.networking.subnet_ids

  tags = {
    Name = "main-db-subnet-group"
  }
}

resource "aws_docdb_cluster_instance" "main" {
  identifier         = "main-db-instance"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = var.db_instance_class

  apply_immediately = true
}
