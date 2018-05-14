resource "random_id" "target_group_sufix" {
  byte_length = 2
}


resource "aws_alb_target_group" "alb_web_target_group" {
  name     = "${var.environment}-alb-target-group-${random_id.target_group_sufix.hex}"
  port     = "${var.web_port}"

  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web_inbound_sg" {
  name        = "${var.environment}-web-inbound-sg"
  description = "Allow HTTP from Anywhere into ALB"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-web-inbound-sg"
  }
}

resource "aws_alb" "alb_web" {
  name            = "${var.environment}-alb-web"
  subnets         = ["${var.public_subnet_ids}"]
  security_groups = ["${var.security_groups_ids}", "${aws_security_group.web_inbound_sg.id}"]

  tags {
    Name        = "${var.environment}-alb-web"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "web" {
  load_balancer_arn = "${aws_alb.alb_web.arn}"
  port              = "${var.web_port}"
  protocol          = "HTTP"
  depends_on        = ["aws_alb_target_group.alb_web_target_group", "aws_alb_listener.web"]

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_web_target_group.arn}"
    type             = "forward"
  }
}
