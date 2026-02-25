provider "aws" {
  region = "us-east-1"
}

variable "key_name" {
  type = string
}

resource "aws_security_group" "swarm" {
  name = "swarm-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "swarm" {
  count         = 2
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t3.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.swarm.name]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              usermod -aG docker ubuntu
              EOF
}
