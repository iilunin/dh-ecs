resource "aws_security_group" "nat" {
	description = "NAT security group"

	vpc_id = "${aws_vpc.main.id}"
	name   = "NAT security group"

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

resource "aws_eip" "nat" {
		instance = "${aws_instance.nat.id}"
		vpc = true
}

resource "aws_instance" "nat" {
		ami = "ami-eccf48fa" # this is a special ami preconfigured to do NAT
		instance_type = "t2.small"
		vpc_security_group_ids = ["${aws_security_group.nat.id}"]
		subnet_id = "${aws_subnet.public.0.id}"
		associate_public_ip_address = true
		source_dest_check = false

		tags {
				Name = "VPC NAT Instance"
		}

		depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_route" "nat_assoc" {
	route_table_id 					= "${aws_route_table.private.id}"
	destination_cidr_block 	= "0.0.0.0/0"
	instance_id 						= "${aws_instance.nat.id}"
}

# If decided to use managed nat uncomment code below

# resource "aws_eip" "nat" {
# }
#
# resource "aws_nat_gateway" "nat" {
# 	allocation_id = "${aws_eip.nat.id}"
# 	subnet_id     = "${aws_subnet.public.0.id}"
# }
#
# resource "aws_route" "nat_assoc" {
# 	route_table_id 					= "${aws_route_table.private.id}"
# 	destination_cidr_block 	= "0.0.0.0/0"
# 	nat_gateway_id 					= "${aws_nat_gateway.nat.id}"
# }
