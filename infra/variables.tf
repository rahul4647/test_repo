
variable "aws_region" {
  description = "The AWS region to deploy in."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "alb_subnets" {
  description = "Subnets for ALB."
  type        = list(string)
}

variable "ecs_subnets" {
  description = "Subnets for ECS."
  type        = list(string)
}

variable "db_subnets" {
  description = "Subnets for Database."
  type        = list(string)
}

variable "next_clerk_webhook_secret" {
  description = "Secret for Clerk Webhook."
  type        = string
}

variable "mongodb_url" {
  description = "URL for MongoDB connection."
  type        = string
}
