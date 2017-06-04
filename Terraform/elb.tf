resource "aws_alb_target_group" "devicehive_http" {
  name     = "DeviceHive-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

resource "aws_alb" "main" {
  name            = "DeviceHive"
  subnets         = ["${aws_subnet.private.*.id}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.devicehive_http.id}"
    type             = "forward"
  }
}
