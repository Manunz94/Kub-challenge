provider "aws" {
  region = "eu-central-1"
}
resource "aws_instance" "manager" {
  ami           = "ami-01e444924a2233b07" 
  instance_type = "t2.medium"
  count         = 1
  tags = {
    Name = "k8s-manager"
  }
}
resource "aws_instance" "worker" {
  ami           = "ami-01e444924a2233b07" 
  instance_type = "t2.medium"
  count         = 2
  tags = {
    Name = "k8s-worker-${count.index}"
  }
}

output "manager_public_ip" {
  value = aws_instance.manager.public_ip
}

output "worker_public_ips" {
  value = [for instance in aws_instance.worker : instance.public_ip]
}