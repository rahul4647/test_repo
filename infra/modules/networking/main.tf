# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "my-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  cidr_block = var.public_subnets[count.index]
  vpc_id = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Create private subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  cidr_block = var.private_subnets[count.index]
  vpc_id = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "private-subnet-${count.index}"
  }
}

# Create a security group
resource "aws_security_group" "this" {
  name = "my-security-group"
  vpc_id = aws_vpc.this.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-security-group"
  }
}
