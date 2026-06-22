variable "region" {
  description = "The AWS region to deploy to."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "app_port" {
  description = "The port the application listens on."
  type        = number
  default     = 3000
}
