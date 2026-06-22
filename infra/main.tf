provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/networking"
}

module "ecs" {
  source = "./modules/compute"
}

module "database" {
  source = "./modules/database"
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
}

module "iam" {
  source = "./modules/iam"
}

module "secrets" {
  source = "./modules/secrets"
}
