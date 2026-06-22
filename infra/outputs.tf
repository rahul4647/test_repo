output "alb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.loadbalancer.alb_dns_name
}

output "db_endpoint" {
  description = "The endpoint of the DocumentDB cluster."
  value       = module.database.db_endpoint
}