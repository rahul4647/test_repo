resource "aws_docdb_cluster" "main" {
  cluster_identifier = "docdb-cluster"
  engine             = "docdb"
  master_username    = "docdbadmin"
  master_password    = "<password>"
  backup_retention_period = 7
  deletion_protection     = true
  storage_encrypted       = true
}

resource "aws_docdb_cluster_instance" "main" {
  count              = 1
  identifier         = "docdb-instance"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = "db.t3.micro"
}