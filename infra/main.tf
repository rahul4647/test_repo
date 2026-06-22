provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
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
