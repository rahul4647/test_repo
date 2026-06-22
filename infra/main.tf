provider "aws" {
  region = "us-east-1"
  version = "~> 5.0"
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"
  vpc_id = module.networking.vpc_id
  alb_security_group_id = module.networking.alb_security_group_id
  ecs_security_group_id = module.networking.ecs_security_group_id
}

module "database" {
  source = "./modules/database"
  vpc_id = module.networking.vpc_id
  database_security_group_id = module.networking.database_security_group_id
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  vpc_id = module.networking.vpc_id
  alb_security_group_id = module.networking.alb_security_group_id
}

module "iam" {
  source = "./modules/iam"
}

module "secrets" {
  source = "./modules/secrets"
}
