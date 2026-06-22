resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "docdb-cluster"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  master_username         = "docdb_admin"
  master_password         = "${random_password.docdb.result}"
  skip_final_snapshot     = false
  deletion_protection     = true
  storage_encrypted       = true
  backup_retention_period = 7
}

resource "aws_docdb_cluster_instance" "main" {
  count               = 1
  identifier          = "docdb-instance-${count.index}"
  instance_class      = "db.t3.micro"
  cluster_identifier  = aws_docdb_cluster.main.id
}

resource "aws_security_group" "db" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }
}
