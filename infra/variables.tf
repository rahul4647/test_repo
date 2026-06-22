variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where resources will be created."
  type        = string
}

variable "alb_subnet_ids" {
  description = "List of subnet IDs for ALB."
  type        = list(string)
}

variable "ecs_subnet_ids" {
  description = "List of subnet IDs for ECS."
  type        = list(string)
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for DocumentDB."
  type        = list(string)
}
