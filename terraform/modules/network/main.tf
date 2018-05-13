# Define a vpc
resource "aws_vpc" "challengeVPC" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "devops-challenge VPC"
    Environment = "${var.environment}"
  }
}
