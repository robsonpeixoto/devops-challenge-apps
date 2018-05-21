/* the task definition for the api service */
data "template_file" "api_task" {
  template = "${file("${path.module}/tasks/api_task_definition.json")}"

  vars {
    image        = "${var.api_image}"
    database_url = "postgresql://${var.database_username}:${var.database_password}@${var.database_endpoint}:5432/${var.database_name}"
    log_group    = "${aws_cloudwatch_log_group.api.name}"
    api_port     = "${var.api_port}"
    region       = "${var.region}"
  }
}

resource "aws_ecs_task_definition" "api" {
  family                   = "${var.environment}_api"
  container_definitions    = "${data.template_file.api_task.rendered}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "${aws_iam_role.ecs_execution_role.arn}"
  task_role_arn            = "${aws_iam_role.ecs_execution_role.arn}"
}
