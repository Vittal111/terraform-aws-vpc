provider "aws" {
    region = "us-east-1"
    //version = "~> 2.46" (No longer necessary)
}

# plan - execute 
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-in28minutes-vittalterra-002"
}
