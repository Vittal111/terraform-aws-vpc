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
  ami = ami-0e449176cecc3e577
}