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

variable "api_port"{
  description = "The port will be used to deploy api"
}
variable "region" {
  description = "The region of aws will be used to launch application"
}

variable "web_port"{
  description = "The port will be used to deploy api"
}

variable "api_url"{
  description = "Url to access api"
}

variable "web_image"{
  description = "The docker image will be used to deploy web application"
}
