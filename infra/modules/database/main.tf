# Create a DocumentDB instance
resource "aws_docdb_cluster" "this" {
  cluster_identifier = var.cluster_identifier
  engine = var.engine
  instance_class = var.instance_class
  storage = var.storage
  multi_az = var.multi_az
  backup_retention = var.backup_retention
  deletion_protection = var.deletion_protection
  encryption_at_rest = var.encryption_at_rest
}

# Create a DocumentDB subnet group
resource "aws_docdb_subnet_group" "this" {
  name = "my-subnet-group"
  subnet_ids = var.subnet_ids
}
