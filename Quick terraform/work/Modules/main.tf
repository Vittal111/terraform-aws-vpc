provider "aws" {
  region = "us-east-2"
}
module "db" {
  source = "./db"
}
module "web" {
  source = "./web"
}
output "PrivateIp" {
  value = module.db.PrivateIp
}
output "public_ip" {
  value = module.web.public_ip
}