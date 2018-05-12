provider "aws" {
  region  = "${var.region}"
}

module "network" {
  source               = "./modules/network"
  environment          = "challenge"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24"]
  private_subnets_cidr = ["10.0.10.0/24"]
  region               = "${var.region}"
  availability_zones   = "${var.availability_zones}"
}
