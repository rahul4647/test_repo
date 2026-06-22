# Output values
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}
output "documentdb_instance_id" {
  value = module.documentdb.documentdb_instance_id
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
