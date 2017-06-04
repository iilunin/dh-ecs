data "template_file" "devicehive_standalone_task" {
  template = "${file("${path.module}/task-definition.json")}"

  vars {
    # image_url        = "devicehive/devicehive-standalone:latest"
    image_url       = "nginx:1.13.1-alpine"
    container_name  = "devicehive-standalone"
  }
}

resource "aws_ecs_task_definition" "devicehive_standalone_task" {
  family                = "devicehive_standalone_task"
  container_definitions = "${data.template_file.devicehive_standalone_task.rendered}"
}

resource "aws_ecs_service" "devicehive_standalone_svc" {
  name            = "deviceHive_standalone_svc"
  cluster         = "${aws_ecs_cluster.devicehive.id}"
  task_definition = "${aws_ecs_task_definition.devicehive_standalone_task.arn}"
  desired_count   = 5
  iam_role        = "${aws_iam_role.ecs_service.name}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.devicehive_http.id}"
    container_name   = "devicehive-standalone"
    container_port   = "80"
  }

  depends_on = [
    "aws_iam_role_policy.ecs_service",
    "aws_alb_listener.front_end",
  ]
}
