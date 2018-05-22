/*====
ECS cluster
======*/
resource "aws_ecs_cluster" "web-cluster" {
  name = "${var.environment}-ecs-web-cluster"
}
