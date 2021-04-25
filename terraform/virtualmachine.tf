provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "wordpress_vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "wordpress_subnet" {
  vpc_id     = aws_vpc.wordpress_vpc.id
  cidr_block = var.subnet_block
}

resource "aws_security_group" "for_instance" {
  name        = "Security group for instance"
  description = "Allow http from vpc and ssh from all world"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.cidr_block
  }
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.all_ips
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.all_ips
  }
}
