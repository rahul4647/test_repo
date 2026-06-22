# Create a DocumentDB instance
resource "aws_documentdb_cluster" "this" {
  cluster_identifier = "my-documentdb-cluster"
  engine = var.db_engine
  master_username = "my-master-username"
  master_password = "my-master-password"
  instance_class = "db.t3.medium"
  storage_encrypted = true
  deletion_protection = true
  vpc_security_group_ids = [aws_security_group.documentdb.id]
  db_subnet_group_name = aws_db_subnet_group.this.name
}

# Create a security group for DocumentDB
resource "aws_security_group" "documentdb" {
  vpc_id = var.vpc_id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-documentdb-sg"
  }
}

# Create a DB subnet group
resource "aws_db_subnet_group" "this" {
  name = "my-documentdb-subnet-group"
  subnet_ids = [aws_subnet.public[0].id]
}
