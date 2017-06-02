resource "aws_ecs_cluster" "devicehive" {
	name = "${var.cluster_name}"
}

data "template_file" "user_data" {
	template = "${file("${path.module}/user-data.sh")}"

	vars {
		cluster_name   = "${aws_ecs_cluster.devicehive.name}"
	}
}

# resource "aws_instance" "ecs_node" {
# 	count = "${var.cluster_size}"
#
# 	ami  = "${var.ecs_ami}"
# 	subnet_id  = "${aws_subnet.public.0.id}"
# 	key_name  = "${var.key_name}"
# 	user_data  = "${data.template_file.user_data.rendered}"
# 	iam_instance_profile  = "${aws_iam_instance_profile.node.name}"
# 	instance_type  = "${var.instance_type}"
# 	vpc_security_group_ids  = ["${aws_security_group.node_security_group.id}"]
#
# 	tags = {
# 		Name  = "DeviceHive ECS Node ${count.index}"
# 	}
# }

resource "aws_launch_configuration" "node" {
	security_groups = ["${aws_security_group.node_security_group.id}"]

	key_name                    = "${var.key_name}"
	image_id                    = "${var.ecs_ami}"
	instance_type               = "${var.instance_type}"
	iam_instance_profile        = "${aws_iam_instance_profile.node.name}"
	user_data                   = "${data.template_file.user_data.rendered}"
	associate_public_ip_address = true

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_autoscaling_group" "ecs_nodes" {
	name                 = "DeviceHive Autoscaling Group"
	vpc_zone_identifier  = ["${aws_subnet.public.0.id}"]
	min_size             = "${var.cluster_size}"
	max_size             = "${var.cluster_size}"
	desired_capacity     = "${var.cluster_size}"
	launch_configuration = "${aws_launch_configuration.node.name}"
}
