resource "aws_cloudwatch_log_group" "web" {
  name = "web"

  tags {
    Environment = "${var.environment}"
    Application = "Web"
  }
}
