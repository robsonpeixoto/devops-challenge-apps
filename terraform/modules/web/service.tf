/* Security Group for ECS */
resource "aws_security_group" "ecs_web_service" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.environment}-ecs-web-service-sg"
  description = "Allow egress from container"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-ecs-service-sg"
    Environment = "${var.environment}"
  }
}

/* Simply specify the family to find the latest ACTIVE revision in that family */
data "aws_ecs_task_definition" "web" {
  task_definition = "${aws_ecs_task_definition.web.family}"
  depends_on      = ["aws_ecs_task_definition.web"]
}

resource "aws_ecs_service" "web" {
  name            = "${var.environment}-web"
  task_definition = "${aws_ecs_task_definition.web.family}:${max("${aws_ecs_task_definition.web.revision}", "${data.aws_ecs_task_definition.web.revision}")}"
  desired_count   = 2
  launch_type     = "FARGATE"
  cluster         = "${aws_ecs_cluster.web-cluster.id}"
  depends_on      = ["aws_iam_role_policy.ecs_service_role_policy"]

  network_configuration {
    security_groups = ["${var.security_groups_ids}", "${aws_security_group.ecs_web_service.id}"]
    subnets         = ["${var.subnets_ids}"]
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.alb_web_target_group.arn}"
    container_name   = "web"
    container_port   = "${var.web_port}"
  }

  depends_on = ["aws_alb_target_group.alb_web_target_group"]
}
