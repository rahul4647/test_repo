output "alb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.loadbalancer.alb_dns_name
}

output "ecs_cluster_id" {
  description = "The ECS cluster ID."
  value       = module.compute.ecs_cluster_id
}

output "documentdb_endpoint" {
  description = "The endpoint for the DocumentDB cluster."
  value       = module.database.documentdb_endpoint
}
