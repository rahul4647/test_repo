# Output variables
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "documentdb_instance_endpoint" {
  value = module.documentdb.instance_endpoint
}

output "alb_dns_name" {
  value = module.alb.dns_name
}