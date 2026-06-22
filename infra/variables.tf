variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "app_port" {
  description = "The port the application listens on."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "The port the DocumentDB instance listens on."
  type        = number
  default     = 27017
}

variable "db_instance_class" {
  description = "The instance class for DocumentDB."
  type        = string
  default     = "db.t3.micro"
}

variable "db_storage" {
  description = "The storage size for DocumentDB in gigabytes."
  type        = number
  default     = 20
}