resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "${var.app_name}-docdb-cluster"
  engine_version          = "4.0.0"
  master_username         = "${var.db_master_username}"
  master_password         = "${var.db_master_password}"
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  storage_encrypted       = true
  backup_retention_period = 14
  deletion_protection     = true

  tags = {
    Name = "${var.app_name}-docdb-cluster"
  }
}

resource "aws_docdb_cluster_instance" "main" {
  count              = 2
  identifier         = "${var.app_name}-docdb-instance-${count.index}"
  instance_class     = "db.t3.medium"
  cluster_identifier = aws_docdb_cluster.main.id

  tags = {
    Name = "${var.app_name}-docdb-instance-${count.index}"
  }
}
