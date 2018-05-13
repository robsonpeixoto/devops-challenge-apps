
# Internet gateway for the public subnet
resource "aws_internet_gateway" "challengeIG" {
  vpc_id = "${aws_vpc.challengeVPC.id}"
  tags {
    Name = "challengeIG"
  }
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = ["aws_internet_gateway.challengeIG"]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${element(aws_subnet.challenge-PubSN.*.id, 0)}"
  depends_on    = ["aws_internet_gateway.challengeIG"]

  tags {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-nat"
    Environment = "${var.environment}"
  }
}

# Public subnet
resource "aws_subnet" "challenge-PubSN" {
  vpc_id                  = "${aws_vpc.challengeVPC.id}"
  count                   = "${length(var.public_subnets_cidr)}"
  cidr_block              = "${element(var.public_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
    Environment = "${var.environment}"
  }
}

# Routing table for public subnet
resource "aws_route_table" "challenge-PubSN-RT" {
  vpc_id = "${aws_vpc.challengeVPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.challengeIG.id}"
  }
  tags {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}

# Associate the routing table to public subnet
resource "aws_route_table_association" "challenge-PubSN-RTAssn" {
  subnet_id = "${aws_subnet.challenge-PubSN.id}"
  route_table_id = "${aws_route_table.challenge-PubSN-RT.id}"
}
