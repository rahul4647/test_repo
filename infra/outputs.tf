output "vpc_id" {
  description = "The VPC ID."
  value       = module.networking.vpc_id
}

output "ecs_cluster_id" {
  description = "The ECS Cluster ID."
  value       = module.compute.ecs_cluster_id
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.loadbalancer.alb_dns_name
}

output "db_endpoint" {
  description = "The endpoint of the database."
  value       = module.database.db_endpoint
}
