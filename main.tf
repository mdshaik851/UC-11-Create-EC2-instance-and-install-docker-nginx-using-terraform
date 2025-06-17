terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
 }

  }
  required_version = ">= 1.10.0"
}

# Security Group for EC2 instances
resource "aws_security_group" "ngnix_instance_sg" {
  name        = "ngnix_instance_sg"
  description = "Security group for ngnix_instance_sg"
  
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "ngnix_instance_sg"
  }
}

# EC2 Instance in primary region
resource "aws_instance" "ngnix_instance" {
  ami               = var.ami # Amazon Linux 2 AMI (update as needed)
  instance_type     = var.instance_type
  security_groups   = [aws_security_group.ngnix_instance_sg.name]
  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt-get install -y docker.io
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo usermod -aG docker ubuntu
                sudo docker run --name mynginx -p 80:80 -d nginx
            EOF

  tags = {
    Name = "ngnix_instance"
  }
}