provider "aws" {
  region  = "${var.region}"
}

module "network" {
  source               = "./modules/network"
  environment          = "${var.environment}"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.10.0/24", "10.0.20.0/24"]
  region               = "${var.region}"
  availability_zones   = "${var.availability_zones}"
}

module "database" {
  source            = "./modules/database"
  environment       = "${var.environment}"
  allocated_storage = "20"
  database_name     = "${var.database_name}"
  database_username = "${var.database_username}"
  database_password = "${var.database_password}"
  subnet_ids        = ["${module.network.private_subnets_id}"]
  vpc_id            = "${module.network.vpc_id}"
  instance_class    = "db.t2.micro"
}

module "api" {
  source            = "./modules/api"
  environment       = "${var.environment}"
  vpc_id            = "${module.network.vpc_id}"
  subnets_ids         = ["${module.network.private_subnets_id}"]
  public_subnet_ids   = ["${module.network.public_subnets_id}"]
  security_groups_ids = [
    "${module.network.security_groups_ids}",
    "${module.database.db_access_sg_id}"
  ]
  database_endpoint   = "${module.database.database_address}"
  database_name       = "${var.database_name}"
  database_username   = "${var.database_username}"
  database_password   = "${var.database_password}"
  api_image           = "${var.api_image}"
  availability_zones  = "${var.availability_zones}"
}
