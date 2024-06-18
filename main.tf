provider "aws" {
  region = "eu-central-1"
}
resource "aws_instance" "manager" {
  ami           = "ami-01e444924a2233b07" # Ubuntu 20.04 LTS - HVM
  instance_type = "t2.medium"
  count         = 1
  tags = {
    Name = "k8s-manager"
  }
}
resource "aws_instance" "worker" {
  ami           = "ami-01e444924a2233b07" # Ubuntu 20.04 LTS - HVM
  instance_type = "t2.medium"
  count         = 2
  tags = {
    Name = "k8s-worker"
  }
}
