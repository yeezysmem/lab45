terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-north-1"
}

resource "aws_instance" "Lab6Instance" {
  ami           = "ami-0ebb6753c095cb52a"
  instance_type = "t4g.nano"
  key_name = "key2"
  security_groups = [aws_security_group.lab6.name]

  user_data = "${file("init.sh")}"

  tags = {
    Name = "Lab6Instance"
  }
}

resource "aws_security_group" "lab6" {
  name        = "lab6"
  description = "lab6"
  vpc_id      = "vpc-0a514b4ea2d4dbdd5"

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "lab6"
  }
}