output "vpc_id" {
  value = module.networking.vpc_id
}

output "alb_dns_name" {
  value = module.loadbalancer.alb_dns_name
}

output "ecs_cluster_arn" {
  value = module.compute.ecs_cluster_arn
}

output "database_endpoint" {
  value = module.database.endpoint
}
