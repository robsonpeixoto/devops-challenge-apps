# Define a vpc
resource "aws_vpc" "challengeVPC" {
  cidr_block = "${var.vpc_cidr}"
  tags {
    Name = "devops-challenge VPC"
  }
}
