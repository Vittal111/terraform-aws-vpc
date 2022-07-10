provider "aws" {
  region = "us-east-1"
}
variable "user_name" {
  type = string
  description = "IAM User name"
}
variable "group1" {
   type = string
   description = "name of IAM Group"
}
variable "group2" {
   type = string
   description = "name of IAM Group"
}
resource "aws_iam_group" "group1" {
  name = var.group1
  path = "/Users"
}
resource "aws_iam_group" "group2" {
  name = var.group2
  path = "/Users"
}
resource "aws_iam_user" "Vittal" {
  name = var.user_name
  path = "/system/"
  tags = {
    "IAM USER" = "USERNAME"
  }
}
resource "aws_iam_access_key" "key" {
user = aws_iam_user.Vittal.name 
}

resource "aws_iam_user_group_membership" "membership1" {
  user = aws_iam_user.Vittal.name
  groups = [
      aws_iam_group.group1.name,
      aws_iam_group.group2.name,
  ]
}

