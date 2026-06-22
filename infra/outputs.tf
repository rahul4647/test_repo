
output "vpc_id" {
  description = "The VPC ID."
  value       = module.networking.vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB."
  value       = module.loadbalancer.alb_dns_name
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  value       = module.compute.ecs_cluster_name
}

output "db_instance_endpoint" {
  description = "The endpoint of the DocumentDB instance."
  value       = module.database.db_instance_endpoint
}
