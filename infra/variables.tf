# Input variables
variable "app_port" {
  type = number
  default = 3000
}
variable "db_port" {
  type = number
  default = 27017
}
variable "db_engine" {
  type = string
  default = "documentdb"
}
