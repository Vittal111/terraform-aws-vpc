provider "aws" {
  region = "us-east-1"
}
variable "name" {
    type = string
    description = "Application Name"
}
variable "environment_name" {
  type = string
  description = "beanstack environment name"
}
variable "template_name" {
  type = string
  description = "beanstack environment template name"
}

variable "max_count" {
    type = number
    description = "Application versions count"
  
}
variable "max_age_in_days" {
  type = number
  description = "number of days the application version to retain"
}

resource "aws_elastic_beanstalk_application" "myapp" {
  name = var.name
  description = "my new node js application"

appversion_lifecycle {
  service_role          = aws_iam_role.beanstalk_service.arn
    max_count             = var.max_count
    delete_source_from_s3 = true
    max_age_in_days = var.max_age_in_days
}
}
resource "aws_elastic_beanstalk_application_version" "nodeversion" {
  name = var.name
  application = aws_elastic_beanstalk_application.myapp.name
  description = "Application version created by user"
  bucket = aws_s3_bucket.default.id
  key = aws_s3_object.nodejz.jar.id
}

resource "aws_s3_bucket" "default" {
    bucket = aws_elastic_beanstalk_application.myapp.bucket
}
resource "aws_s3_object" "nodejzjar" {
  bucket = aws_s3_bucket.default.id
  key    = "beanstalk/go-v1.zip"
  source = "go-v1.zip"
}
resource "aws_elastic_beanstalk_environment" "myenvironment" {
  name = var.environment_name
  application = aws_elastic_beanstalk_application.myapp.name
  solution_stack_name = "my environment stack"
  template_name = var.template_name
}

