output "database_address" {
  value = "${aws_db_instance.database.address}"
}

output "db_access_sg_id" {
  value = "${aws_security_group.db_access_sg.id}"
}
