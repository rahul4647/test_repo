# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "my-vpc"
  }
}

# Create subnets
resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-subnet-${count.index}"
  }
}

# Create security groups
resource "aws_security_group" "vpc" {
  vpc_id = aws_vpc.this.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-vpc-sg"
  }
}

# Create VPC flow logs
resource "aws_flow_log" "this" {
  iam_role_arn = aws_iam_role.vpc_flow_logs.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  traffic_type = "ALL"
  vpc_id = aws_vpc.this.id
}

# Create IAM role for VPC flow logs
resource "aws_iam_role" "vpc_flow_logs" {
  name = "my-vpc-flow-logs"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

# Create CloudWatch log group for VPC flow logs
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name = "my-vpc-flow-logs"
}
