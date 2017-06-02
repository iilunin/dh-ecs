resource "aws_security_group" "node_security_group" {
  description = "Direct access to EC2 instance"
  vpc_id      = "${aws_vpc.main.id}"
  name        = "DeviceHive ECS Node SG"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "icmp"
    from_port = -1
    to_port   = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   protocol  = "tcp"
  #   from_port = 8080
  #   to_port   = 8080
  #
  #   security_groups = [
  #     "${aws_security_group.lb_sg.id}",
  #   ]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
