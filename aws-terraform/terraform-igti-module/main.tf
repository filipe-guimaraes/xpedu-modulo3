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

resource "aws_instance" "app_server" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t3a.small"
  vpc_security_group_ids = [ "${module.security_group_app_server.app_server_sg_id}" ]
  tags = {
    Name = "Instancia EC2 - Com Modulo",
    Change = "True",
    Desliga = "True"
  }
}

resource "aws_eip" "app_server" {
  instance = aws_instance.app_server.id
  vpc      = true
}

module "security_group_app_server" {
  source = "./modules/sg"
}