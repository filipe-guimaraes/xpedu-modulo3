terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_security_group" "app_server_sg" {
  name    = "app_server_sg"
}

############ Inbound Rules ############
resource "aws_security_group_rule" "app_server_sg_inbound_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_security_group_rule" "app_server_sg_inbound_3306" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}
resource "aws_security_group_rule" "app_server_sg_inbound_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_security_group_rule" "app_server_sg_inbound_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

############ Outbound Rules ############
resource "aws_security_group_rule" "app_server_sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_instance" "app_server" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t3a.medium"
  vpc_security_group_ids = [ "${aws_security_group.app_server_sg.id}" ]
  tags = {
    Name = "Instancia EC2 - Sem Modulo",
    Change = "True",
    Desliga = "True"
  }
}

resource "aws_eip" "app_server" {
  instance = aws_instance.app_server.id
  vpc      = true
}