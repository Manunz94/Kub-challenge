provider "aws" {
  region = "eu-central-1"
}

data "aws_key_pair" "existing" {
  key_name = "xmob"
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"

  ingress {
    from_port   = 22
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
}

variable "vpc_id" {
  default = "vpc-0de3a6f018ddfa754"
}

variable "subnet_id_public" {
  default = "subnet-06160d9e5f0521aa0"
}

resource "aws_instance" "manager" {
  ami           = "ami-01e444924a2233b07" # Ubuntu 20.04 LTS - HVM
  instance_type = "t2.medium"
  count         = 1
  key_name      = data.aws_key_pair.existing.key_name
  #security_groups = [aws_security_group.ssh_access.name]
  subnet_id     = var.subnet_id_public
  tags = {
    Name = "k8s-manager"
  }
}

resource "aws_instance" "worker" {
  ami           = "ami-01e444924a2233b07" # Ubuntu 20.04 LTS - HVM
  instance_type = "t2.medium"
  count         = 2
  key_name      = data.aws_key_pair.existing.key_name
  #security_groups = [aws_security_group.ssh_access.name]
  subnet_id     = var.subnet_id_public
  tags = {
    Name = "k8s-worker"
  }
}

//variable "public_key_path" {
  //type        = string
//}