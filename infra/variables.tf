variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role."
  type        = string
}

variable "documentdb_cluster_id" {
  description = "The ID of the DocumentDB cluster."
  type        = string
}
