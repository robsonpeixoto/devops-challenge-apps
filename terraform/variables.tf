variable "region" {
  description = "The region of aws will be used to launch application"
}

variable "availability_zones" {
  type        = "list"
  description = "The az avaiable to launch application"
}

variable "database_name" {
  description = "The database name"
}

variable "database_username" {
  description = "The username for database"
}

variable "database_password" {
  description = "The user password for database"
}

variable "environment" {
  description = "The environment"
}

variable "api_image"{
  description = "The docker image will be used to deploy api"
}

variable "api_port"{
  description = "The port will be used to deploy api"
  default = 5000
}
variable "web_port"{
  description = "The port will be used to deploy api"
  default = 3000
}

variable "web_image"{
  description = "The docker image will be used to deploy web application"
}
