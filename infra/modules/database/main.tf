# Create a DocumentDB instance
resource "aws_docdb_instance" "this" {
  identifier           = "main-db"
  instance_class       = var.instance_class
  engine               = "docdb"
  storage_type         = "gp2"
  storage_size         = var.storage
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name = aws_db_subnet_group.this.name
  multi_az             = var.multi_az
  deletion_protection  = true
  storage_encrypted     = true
  skip_final_snapshot   = false
}

# Create a security group for the database
resource "aws_security_group" "db" {
  name        = "db-sg"
  description = "Database security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a DB subnet group
resource "aws_db_subnet_group" "this" {
  name       = "main-db-subnet-group"
  subnet_ids = var.subnet_ids
}
