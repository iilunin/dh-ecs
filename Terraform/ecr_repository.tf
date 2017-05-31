resource "aws_ecr_repository" "admin" {
  name = "admin"
}

resource "aws_ecr_repository" "server" {
  name = "server"
}

resource "aws_ecr_repository" "broker" {
  name = "broker"
}

resource "aws_ecr_repository" "persistence" {
  name = "persistence"
}
