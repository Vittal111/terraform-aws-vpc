resource "aws_instance" "db" {
  ami = "ami-032598fcc7e9d1c7a"
  instance_type = "t2.micro"
  tags = {
    "server" = "dbserver"
  }
  
}
output "PrivateIp" {
    value = aws_instance.db.private_ip
  }