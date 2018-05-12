# private subnet
resource "aws_subnet" "challenge-PrivSN0" {
  vpc_id                  = "${aws_vpc.challengeVPC.id}"
  count                   = "${length(var.private_subnets_cidr)}"
  cidr_block              = "${element(var.private_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = false
  tags {
    Name = "${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
    Environment = "${var.environment}"
  }
}

# Routing table for private subnet
resource "aws_route_table" "challenge-PrivSN0-RT" {
  vpc_id = "${aws_vpc.challengeVPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.challengeIG.id}"
  }
  tags {
    Name        = "${var.environment}-private-route-table"
    Environment = "${var.environment}"
  }
}

# Associate the routing table to private subnet
resource "aws_route_table_association" "challenge-PrivSN0-RTAssn" {
  subnet_id = "${aws_subnet.challenge-PrivSN0.id}"
  route_table_id = "${aws_route_table.challenge-PrivSN0-RT.id}"
}
