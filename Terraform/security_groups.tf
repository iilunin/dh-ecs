resource "aws_security_group" "node_security_group" {
	description = "Direct access to EC2 instance"
	vpc_id      = "${aws_vpc.main.id}"
	name        = "DeviceHive ECS Node SG"

	ingress {
		protocol = -1
		from_port = 0
		to_port = 0
		cidr_blocks = ["${aws_vpc.main.cidr_block}"]
	}

	ingress {
		protocol  = -1
		from_port = 0
		to_port   = 0

		security_groups = [
			"${aws_security_group.lb_sg.id}"
		]
	}

	ingress {
		protocol  = -1
		from_port = 0
		to_port   = 0
		self = true
	}

	ingress {
		protocol  = "tcp"
		from_port = 22
		to_port   = 22

		cidr_blocks = ["0.0.0.0/0"]
	}

	# ingress {
	# 	protocol  = "tcp"
	# 	from_port = 80
	# 	to_port   = 80
	#
	# 	cidr_blocks = ["0.0.0.0/0"]
	# }
	#
	# ingress {
	# 	protocol  = "icmp"
	# 	from_port = -1
	# 	to_port   = -1
	# 	cidr_blocks = ["0.0.0.0/0"]
	# }

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_security_group" "lb_sg" {
	description = "controls access to the application ELB"

	vpc_id = "${aws_vpc.main.id}"
	name   = "DeviceHive Load Balancer SG"

	ingress {
		protocol    = "tcp"
		from_port   = 80
		to_port     = 80
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port   = 0
		protocol  = "-1"

		cidr_blocks = [
			"0.0.0.0/0"
		]
	}
}
