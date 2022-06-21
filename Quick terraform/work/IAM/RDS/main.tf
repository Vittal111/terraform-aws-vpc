provider "aws" {
  region = "us-east-1"
}
variable "instance_class" {
  type = string
  description = "provide the type of db instance :"
}
variable "name" {
  type = string
  description = "Name of the Database :"
}
variable "username" {
    type = string
    description = "Enter the Master user name :"
}
variable "password" {
  type = string
  description = "Enter the Master password : "
}
variable "availability_zone" {
  type = string
  description = "enter the availability zone for Db instance"
}
variable "backup_retention_period" {
    type = number
    description = "enter the no of days to retain the backup :"
  
}
variable "backup_window" {
    type = string
    description = "enter the backup window"
  
}
variable "db_name" {
    type = string
    description = "enter the db Name :"
  
}

resource "aws_db_instance" "mydb" {
  allocated_storage = 10
  engine = mysql
  engine_version = "5.7"
  instance_class = var.instance_class
  name = var.name
  username = var.username
  password = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  max_allocated_storage = 1000
  allow_major_version_upgrade = true
  apply_immediately = false
  auto_minor_version_upgrade = true
  availability_zone = var.availability_zone
  backup_retention_period = var.backup_retention_period
  backup_window = var.backup_window
  db_name = var.db_name
}
