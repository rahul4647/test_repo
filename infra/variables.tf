variable "region" {
  description = "The AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "app_port" {
  description = "The port the application listens on."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "The port the database listens on."
  type        = number
  default     = 27017
}
