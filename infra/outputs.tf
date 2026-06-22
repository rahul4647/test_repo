output "vpc_id" {
  value = module.networking.vpc_id
}

output "ecs_cluster_id" {
  value = module.compute.cluster_id
}

output "db_instance_endpoint" {
  value = module.database.endpoint
}

output "alb_dns_name" {
  value = module.loadbalancer.dns_name
}
