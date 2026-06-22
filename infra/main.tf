# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  version = "~> 5.0"
}

# Create a VPC
module "vpc" {
  source = "../../modules/networking"

  cidr_block = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Create an ECS cluster
module "ecs" {
  source = "../../modules/compute"

  cluster_name = "my-ecs-cluster"
  container_instances = 2
  instance_type = "t3.medium"
  cpu = 1024
  memory = 2048
}

# Create an RDS instance
module "rds" {
  source = "../../modules/database"

  engine = "documentdb"
  instance_class = "db.t3.medium"
  storage = 50
  multi_az = true
  backup_retention = 14
  deletion_protection = true
  encryption_at_rest = true
}

# Create an ELB
module "elb" {
  source = "../../modules/loadbalancer"

  name = "my-elb"
  subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  security_groups = [module.vpc.security_group_id]
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}
