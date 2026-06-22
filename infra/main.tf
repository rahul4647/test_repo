provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"
  vpc_id = module.networking.vpc_id
  alb_sg_id = module.networking.alb_sg_id
  ecs_sg_id = module.networking.ecs_sg_id
  db_sg_id = module.networking.db_sg_id
}

module "database" {
  source = "./modules/database"
  vpc_id = module.networking.vpc_id
  db_sg_id = module.networking.db_sg_id
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  vpc_id = module.networking.vpc_id
  alb_sg_id = module.networking.alb_sg_id
}

module "iam" {
  source = "./modules/iam"
}

module "secrets" {
  source = "./modules/secrets"
}
