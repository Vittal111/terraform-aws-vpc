resource "aws_instance" "web" {
  ami = "ami-032598fcc7e9d1c7a"
  instance_type = "t2.micro"
  security_groups = [module.sg.sg_name]
  tags = {
    "server" = "webserver"
  }
  user_data = file("./web/server-script.sh")
}

module "eip" {
  source = "../eip"
  instance_id = aws_instance.web.id
}
module "sg" {
  source = "../sg"
}

output "public_ip" {
  value = module.eip.public_ip
}