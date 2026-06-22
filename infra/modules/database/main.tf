# Create a DocumentDB database
resource "aws_docdb_cluster" "this" {
  cluster_identifier = "example-cluster"
  engine = "docdb"
  master_username = var.db_username
  master_password = var.db_password
  instance_class = "db.t3.medium"
  storage_encrypted = true
  deletion_protection = true
  skip_final_snapshot = false
  vpc_security_group_ids = [aws_security_group.documentdb.id]
}

# Create a DocumentDB instance
resource "aws_docdb_instance" "this" {
  identifier = "example-instance"
  cluster_identifier = aws_docdb_cluster.this.id
  instance_class = "db.t3.medium"
  engine = "docdb"
  availability_zone = data.aws_availability_zones.available.names[0]
}