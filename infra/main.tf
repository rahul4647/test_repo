# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  version = "~> 5.0"
}

# Create a VPC
module "vpc" {
  source = "../modules/networking"
}

# Create an ECS cluster
module "ecs" {
  source = "../modules/compute"
  vpc_id = module.vpc.vpc_id
}

# Create a DocumentDB instance
module "documentdb" {
  source = "../modules/database"
  vpc_id = module.vpc.vpc_id
}

# Create an ALB
module "alb" {
  source = "../modules/loadbalancer"
  vpc_id = module.vpc.vpc_id
}
