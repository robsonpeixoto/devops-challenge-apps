provider "aws" {
  region  = "${var.region}"
}

module "network" {
  source               = "./modules/network"
  environment          = "${var.environment}"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24"]
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
