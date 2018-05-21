/* the task definition for the web service */
data "template_file" "web_task" {
  template = "${file("${path.module}/tasks/web_task_definition.json")}"

  vars {
    image     = "${var.web_image}"
    api_url   = "http://${var.api_url}:${var.api_port}"
    log_group = "${aws_cloudwatch_log_group.web.name}"
    web_port  = "${var.web_port}"
    region    = "${var.region}"
  }
}

resource "aws_ecs_task_definition" "web" {
  family                   = "${var.environment}_web"
  container_definitions    = "${data.template_file.web_task.rendered}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "${aws_iam_role.ecs_execution_role-web.arn}"
  task_role_arn            = "${aws_iam_role.ecs_execution_role-web.arn}"
}
