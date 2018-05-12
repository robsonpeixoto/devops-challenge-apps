variable "region" {
  description = "The region of aws will be used to launch application"
}

variable "availability_zones" {
  type        = "list"
  description = "The az avaiable to launch application"
}
