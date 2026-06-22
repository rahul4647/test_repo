# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# Create a VPC
module "vpc" {
  source = "./modules/networking"

  cidr_block = var.cidr_block
}

# Create an ECS cluster
module "ecs" {
  source = "./modules/compute"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  instance_type = var.instance_type
  cpu = var.cpu
  memory = var.memory
}

# Create a DocumentDB instance
module "documentdb" {
  source = "./modules/database"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  instance_class = var.instance_class
  storage = var.storage
  multi_az = var.multi_az
}

# Create an ALB
module "alb" {
  source = "./modules/loadbalancer"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  instance_type = var.instance_type
  cpu = var.cpu
  memory = var.memory
}
