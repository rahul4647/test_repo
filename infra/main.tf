# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  version = "~> 5.0"
}

# Create a VPC
module "vpc" {
  source = "../../modules/networking"
}

# Create an ECS cluster
module "ecs" {
  source = "../../modules/compute"
  vpc_id = module.vpc.vpc_id
}

# Create a DocumentDB database
module "documentdb" {
  source = "../../modules/database"
  vpc_id = module.vpc.vpc_id
}

# Create an Application Load Balancer
module "alb" {
  source = "../../modules/loadbalancer"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
}

# Create IAM roles and policies
module "iam" {
  source = "../../modules/iam"
}

# Create a Secrets Manager
module "secrets" {
  source = "../../modules/secrets"
}