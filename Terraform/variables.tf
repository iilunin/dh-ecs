variable "aws_region" {
  default = "us-east-1"
}

variable "version" {
  default = "0.0.1"
}

variable "cluster_size" {
  default = "1"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "az_count" {
  default = "2"
}
