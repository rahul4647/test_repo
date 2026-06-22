resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "docdb-cluster"
  engine_version          = "4.0.0"
  master_username         = "admin"
  master_password         = "${var.master_password}"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  storage_encrypted       = true
  deletion_protection     = true
  skip_final_snapshot     = false

  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

resource "aws_docdb_cluster_instance" "main" {
  count              = 1
  identifier         = "docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = var.db_instance_class
}

resource "aws_security_group" "db_sg" {
  vpc_id = module.networking.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
  }
}