provider "aws" {
  region  = var.aws_region
  version = "~> 5.0"
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source      = "./modules/compute"
  vpc_id      = module.networking.vpc_id
  subnet_ids  = module.networking.private_subnet_ids
  security_groups = [module.networking.ecs_security_group_id]
}

module "database" {
  source = "./modules/database"
  vpc_id = module.networking.vpc_id
  subnet_ids = module.networking.private_subnet_ids
  security_group_id = module.networking.db_security_group_id
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  vpc_id = module.networking.vpc_id
  subnet_ids = module.networking.public_subnet_ids
  security_group_id = module.networking.alb_security_group_id
}

module "iam" {
  source = "./modules/iam"
}

module "secrets" {
  source = "./modules/secrets"
}
