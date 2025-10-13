terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "nhan-terraform-state"
    key    = "monitoring/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

# Security group mở các port cần thiết
resource "aws_security_group" "monitor_sg" {
  name        = "monitoring-sg"
  description = "Allow web, grafana, prometheus, mongodb"
  vpc_id      = "vpc-010eac1b38064478e"

  ingress = [
    for port in [22, 3000, 4000, 9090, 27017] : {
      description = "Allow inbound on port ${port}"
      from_port   = port
      to_port     = port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 chạy Docker
resource "aws_instance" "monitor_node" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04
  instance_type = "t2.micro"
  key_name      = "nhan-key"
  vpc_security_group_ids = [aws_security_group.monitor_sg.id]
  tags = {
    Name = "MonitorServer"
  }
}
