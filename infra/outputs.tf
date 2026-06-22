output "alb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.loadbalancer.alb_dns_name
}

output "database_endpoint" {
  description = "The endpoint of the database."
  value       = module.database.endpoint
}
