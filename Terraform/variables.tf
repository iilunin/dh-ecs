variable "aws_region" {
  default = "us-east-1"
}

variable "version" {
  default = "0.0.1"
}

# TODO: add min/max/desired
variable "cluster_size" {
  default = "3"
}

variable "cluster_name" {
  default = "devicehive"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "az_count" {
  default = "1"
}

variable "instance_type" {
  default     = "t2.small"
}

variable "ecs_ami" {
  default = "ami-275ffe31"
}

variable "key_name" {
  default = ""
}
