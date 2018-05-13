output "vpc_id" {
  value = "${aws_vpc.challengeVPC.id}"
}

output "public_subnets_id" {
  value = ["${aws_subnet.challenge-PubSN.*.id}"]
}

output "private_subnets_id" {
  value = ["${aws_subnet.challenge-PrivSN.*.id}"]
}

output "default_sg_id" {
  value = "${aws_security_group.default.id}"
}

output "security_groups_ids" {
  value = ["${aws_security_group.default.id}"]
}
