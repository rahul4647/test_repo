output "vpc_id" {
  value = module.vpc.vpc_id
}
output "subnet_ids" {
  value = module.vpc.subnet_ids
}
output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}
output "documentdb_instance_id" {
  value = module.documentdb.documentdb_instance_id
}
output "alb_id" {
  value = module.alb.alb_id
}
