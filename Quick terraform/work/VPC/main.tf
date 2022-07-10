provider "aws" {
  region = "us-east-1"
}
variable "cidr_block" {
  type = string
  description = "enter the CIDR Block range : "
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block
}

resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "main"
  }
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.myvpc.default_network_acl_id

  ingress {
    protocol = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
resource "aws_default_route_table" "route" {
  default_route_table_id = aws_vpc.myvpc.default_route_table_id

  route{
    cidr_block = aws_vpc.myvpc.cidr_block
    gateway_id = aws_internet_gateway.mygateway.id
  }
}

resource "aws_security_group" "default" {
  vpc_id = aws_vpc.myvpc.id

  egress{
    protocol = -1
    from_port = 0
    to_port = 0
    self = true
  }

  ingress{
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}