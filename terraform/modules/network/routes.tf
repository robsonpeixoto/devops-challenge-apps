resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.challenge-PrivSN-RT.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.challenge-PubSN-RT.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.challengeIG.id}"
}
