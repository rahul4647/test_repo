variable "vpc_id" {}
variable "alb_security_group_id" {}
variable "ecs_security_group_id" {}
variable "database_security_group_id" {}
variable "region" {
  default = "us-east-1"
}
