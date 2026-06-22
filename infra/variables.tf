variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The VPC ID for networking resources."
  type        = string
}

variable "app_port" {
  description = "The port on which the application listens."
  type        = number
  default     = 3000
}