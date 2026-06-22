output "vpc_id" {
  value = module.networking.vpc_id
}

output "alb_dns_name" {
  value = module.loadbalancer.alb_dns_name
}

output "db_endpoint" {
  value = module.database.db_endpoint
}

output "ecs_cluster_name" {
  value = module.compute.ecs_cluster_name
}
