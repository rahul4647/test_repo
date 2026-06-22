output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ecs_cluster_id" {
  value = module.ecs.cluster_id
}

output "db_endpoint" {
  value = module.database.endpoint
}
