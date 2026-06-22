provider "aws" {
  region  = var.region
  version = "~> 5.0"
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"
  vpc_id = module.networking.vpc_id
  alb_sg_id = module.networking.alb_sg_id
}

module "database" {
  source = "./modules/database"
  vpc_id = module.networking.vpc_id
  db_subnet_group_name = module.networking.db_subnet_group_name
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  vpc_id = module.networking.vpc_id
  alb_sg_id = module.networking.alb_sg_id
  alb_target_group_arn = module.compute.alb_target_group_arn
}

module "iam" {
  source = "./modules/iam"
}

module "secrets" {
  source = "./modules/secrets"
}
