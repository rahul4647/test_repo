output "vpc_id" {
  description = "The VPC ID."
  value       = module.networking.vpc_id
}

output "ecs_service_name" {
  description = "The name of the ECS service."
  value       = module.compute.ecs_service_name
}

output "documentdb_endpoint" {
  description = "The endpoint of the DocumentDB cluster."
  value       = module.database.documentdb_endpoint
}
