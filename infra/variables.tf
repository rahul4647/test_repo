variable "aws_region" {
  description = "The AWS region to deploy to."
  type        = string
  default     = "us-east-1"
}

variable "app_port" {
  description = "The port the application will run on."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "The port the database will run on."
  type        = number
  default     = 27017
}

variable "db_storage" {
  description = "The storage size for the database."
  type        = number
  default     = 20
}

variable "db_instance_class" {
  description = "The instance class for the database."
  type        = string
  default     = "db.t3.micro"
}
