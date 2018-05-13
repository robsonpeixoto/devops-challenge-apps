/*====
ECS cluster
======*/
resource "aws_ecs_cluster" "api-cluster" {
  name = "${var.environment}-ecs-cluster"
}
