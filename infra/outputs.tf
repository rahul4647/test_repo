# Output variables
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "rds_instance_id" {
  value = module.rds.instance_id
}

output "elb_dns_name" {
  value = module.elb.dns_name
}
