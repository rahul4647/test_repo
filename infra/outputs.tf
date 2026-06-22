output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.networking.vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB."
  value       = module.loadbalancer.alb_dns_name
}
