resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "main-docdb"
  master_username         = "admin"
  master_password         = "CHANGEME"
  db_subnet_group_name    = aws_docdb_subnet_group.main.name
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  storage_encrypted       = true
  deletion_protection     = true
}

resource "aws_docdb_subnet_group" "main" {
  name       = "main-docdb-subnet-group"
  subnet_ids = module.networking.private_subnets
}

resource "aws_docdb_cluster_instance" "main" {
  count               = 1
  identifier          = "main-docdb-instance"
  cluster_identifier  = aws_docdb_cluster.main.id
  instance_class      = "db.t3.micro"
  apply_immediately   = true
}
