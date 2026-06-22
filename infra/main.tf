provider "aws" {
  region  = var.region
  version = "~> 5.0"
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"
  alb_security_group_id = module.networking.alb_security_group_id
  ecs_security_group_id = module.networking.ecs_security_group_id
  vpc_id = module.networking.vpc_id
  subnets = module.networking.public_subnets
}

module "database" {
  source = "./modules/database"
  vpc_id = module.networking.vpc_id
  database_security_group_id = module.networking.database_security_group_id
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  alb_security_group_id = module.networking.alb_security_group_id
  vpc_id = module.networking.vpc_id
  subnets = module.networking.public_subnets
}

module "iam" {
  source = "./modules/iam"
}

module "secrets" {
  source = "./modules/secrets"
}
