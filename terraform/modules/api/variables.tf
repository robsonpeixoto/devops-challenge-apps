variable "environment" {
  description = "The environment"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "availability_zones" {
  type        = "list"
  description = "The azs to use"
}

variable "security_groups_ids" {
  type        = "list"
  description = "The SGs to use"
}

variable "subnets_ids" {
  type        = "list"
  description = "The private subnets to use"
}

variable "public_subnet_ids" {
  type        = "list"
  description = "The private subnets to use"
}

variable "database_endpoint" {
  description = "The database endpoint"
}

variable "database_username" {
  description = "The database username"
}

variable "database_password" {
  description = "The database password"
}

variable "database_name" {
  description = "The database that the app will use"
}

variable "api_image"{
  description = "The docker image will be used to deploy api"
}

variable "api_port"{
  description = "The port will be used to deploy api"
  default = 5000
}
variable "region" {
  description = "The region of aws will be used to launch application"
}
