output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.networking.vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.loadbalancer.alb_dns_name
}

output "db_endpoint" {
  description = "The connection endpoint for the DocumentDB cluster."
  value       = module.database.endpoint
}