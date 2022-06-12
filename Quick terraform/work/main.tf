provider "aws" {
  region = "us-east-1"
}

variable "cidr_block" {
  type = string
  description = "enter the CIDR ip range"
}
variable "instance_type" {
    type = string
    description = "type of instance"
}
variable "key_name" {
  type = string
  description = "ec2 key pair name"  
}

resource "aws_vpc" "mynew" {
    cidr_block = var.cidr_block
    tags = {
      "name" = "mynew vpc"
    }
}

resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.mynew.id
  tags = {
    "name" = "mygateway"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.mynew.id
  cidr_block = var.cidr_block
  tags = {
    "name" = "mysubnet1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.mynew.id
  cidr_block = var.cidr_block
  tags = {
    "name" = "mysubnet2"
  }
}

resource "aws_instance" "myec2" {
  instance_type = var.instance_type
  ami = "ami-0e449176cecc3e577"
  count = 2
  associate_public_ip_address = true
  disable_api_termination = true
  hibernation = true 
  key_name = var.key_name
}
resource "aws_key_pair" "jenkin" {
  key_name = var.key_name
  public_key = "ssa-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCx9cWQeDh9uYcF06+QSJu1MElM92D52Hf4rD9ZBPkp5DuE7FlraV+WtbtMWK8cNvFdE5sFYoISMzxAnZ9+DzxkAtrFw4sD4iAVZwMorcsrvUphF2msSO+jk+88VTjHjkCwIKC9cjugcOv8cl4XeQnvp05sP3U7zRHuTtQY/miSZEGnhw1cgsXsa85TbRoiURYPugJW8l8v9u0p8drtm+3TjLhr4iqT7zZcBLYBIfVUmSbkD0jh/FIDSVp4mDzTT367v4Iw+Jid34JIBPy2mdnJl5xv3caZ6Ok1cGj2xcCKFTveOuA3/1ZCNEajR+ZMXkYmuiapexcCXb7o1DVNWd/5" 
}