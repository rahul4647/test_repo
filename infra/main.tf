provider "aws" {
  region = var.region
  version = "~> 5.0"
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"
  alb_security_group_id = module.networking.alb_security_group_id
  ecs_security_group_id = module.networking.ecs_security_group_id
  db_security_group_id = module.networking.db_security_group_id
}

module "database" {
  source = "./modules/database"
  db_security_group_id = module.networking.db_security_group_id
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
  alb_security_group_id = module.networking.alb_security_group_id
}

module "iam" {
  source = "./modules/iam"
}

module "secrets" {
  source = "./modules/secrets"
}
